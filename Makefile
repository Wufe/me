# Application name
APP_NAME ?= app

QUIET ?= false

# Docker compose files
DEV_COM_COMPOSE_FILE := environment/docker/compose/development/common.yml
DEV_APP_COMPOSE_FILE := environment/docker/compose/development/app.yml

REL_COM_COMPOSE_FILE := environment/docker/compose/release/common.yml
REL_APP_COMPOSE_FILE := environment/docker/compose/release/app.yml

# Folders
BIN_FOLDER := bin

APP_FOLDER := src
APP_BACKEND_FOLDER ?= $(APP_FOLDER)/backend
APP_FRONTEND_FOLDER ?= $(APP_FOLDER)/frontend

# Commands
CHMOD := chmod
DOCKER := docker
DOCKER_COMPOSE := docker-compose
NODE := node
ARTISAN := $(BIN_FOLDER)/artisan
GIT := git

# Git repositories

ANSIBLE_IMAGE_PATH := environment/docker/images/ansible
ANSIBLE_IMAGE_REPO := https://github.com/Wufe/docker-ansible
PHP_IMAGE_PATH := environment/docker/images/php70
PHP_IMAGE_REPO := https://github.com/Wufe/docker-php70

# Docker compose files
DEV_COMPOSE_FILES := -f $(DEV_COM_COMPOSE_FILE) -f $(DEV_APP_COMPOSE_FILE)
REL_COMPOSE_FILES := -f $(REL_COM_COMPOSE_FILE) -f $(REL_APP_COMPOSE_FILE)

# Docker compose command base
DEV_COMPOSE_CMD := $(DOCKER_COMPOSE) -p $(APP_NAME) $(DEV_COMPOSE_FILES)
REL_COMPOSE_CMD := $(DOCKER_COMPOSE) -p $(APP_NAME) $(REL_COMPOSE_FILES)

# Docker wipe command
DOCKER_COMPOSE_KILL := $(DEV_COMPOSE_CMD) kill
DOCKER_COMPOSE_RM := $(DEV_COMPOSE_CMD) rm -f -v

# Docker run command
DOCKER_RUN := docker run -it --rm

# NPM commands
NPM_INSTALL_ROOT := $(DOCKER_RUN) -w /app -v `pwd`:/app node:wheezy npm install -s
NPM_INSTALL_BACKEND := $(DOCKER_RUN) -w /app -v `pwd`/$(APP_BACKEND_FOLDER):/app node:wheezy npm install -s
NPM_INSTALL_FRONTEND := $(DOCKER_RUN) -w /app -v `pwd`/$(APP_FRONTEND_FOLDER):/app node:wheezy npm install -s
NPM_BUILD_FRONTEND := $(DOCKER_RUN) -w /app -v `pwd`:/app node:wheezy npm run pack -s

# Composer commands
COMPOSER_INSTALL_APP := $(DOCKER_RUN) -w /app -v `pwd`/$(APP_BACKEND_FOLDER):/app composer/composer install
COMPOSER_RUN_POST_INSTALL := $(DOCKER_RUN) -w /app -v `pwd`/$(APP_BACKEND_FOLDER):/app composer/composer run-script post-root-package-install
COMPOSER_RUN_POST_CREATE := $(DOCKER_RUN) -w /app -v `pwd`/$(APP_BACKEND_FOLDER):/app composer/composer run-script post-create-project-cmd

RED := "\e[1;30m"
YELLOW := "\e[1;33m"
NC := "\e[0m"

INFO := @bash -c '\
	printf $(YELLOW); \
	echo "=> $$1"; \
	printf $(NC)' VALUE

ifeq ($(QUIET),true)
	CMD := @bash -c '\
	$$* >/dev/null; \
	' VALUE
endif

ifeq ($(QUIET),false)
	CMD := @bash -c '\
	printf $(RED); \
	echo "=> $$*"; \
	$$*; \
	printf $(NC)' VALUE
endif

.PHONY: build clean init-project install npm-install reset run setup start test wipe tt

clean:
	${INFO} "Cleaning environment.."
	${CMD} rm -rf environment/docker/images/*
	${CMD} rm -rf mysql_data
	${CMD} rm -rf node_modules
	${CMD} rm -rf src/backend/vendor
	${CMD} rm -rf src/backend/node_modules
	${CMD} rm -rf src/frontend/node_modules
	${CMD} rm -rf src/backend/.env
	${CMD} rm -rf src/backend/public/assets/javascript/*.bundle.js*
	${CMD} rm -rf src/backend/public/assets/javascript/*chunk.js*
	${INFO} "Done."

build:
	# Needs to be executed only after install or npm-install
	${INFO} "Building development environment.."
	# ${CMD} $(DEV_COMPOSE_CMD) build
	${INFO} "Building javascript using webpack.."
	${CMD} $(NPM_BUILD_FRONTEND)
	${INFO} "Done."

init-project:
	${INFO} "Executing post-root-package-install.."
	${CMD} $(COMPOSER_RUN_POST_INSTALL)
	${INFO} "Executing post-create-project-cmd.."
	${CMD} $(COMPOSER_RUN_POST_CREATE)
	${INFO} "Done."

install:
	@make npm-install
	@make composer-install
	@make build
	${INFO} "Changing permissions.."
	${CMD} $(CHMOD) +x $(BIN_FOLDER)/*
	${INFO} "Done."

npm-install:
	${INFO} "Installing npm dependencies.."
	${CMD} $(NPM_INSTALL_ROOT)
	${CMD} $(NPM_INSTALL_BACKEND)
	${CMD} $(NPM_INSTALL_FRONTEND)
	${INFO} "Done."

composer-install:
	${INFO} "Installing composer dependencies.."
	${CMD} $(COMPOSER_INSTALL_APP)
	${INFO} "Done."

setup:
	${INFO} "Downloading docker images.."
	if ! [ -d "$(ANSIBLE_IMAGE_PATH)" ]; then \
		$(GIT) clone $(ANSIBLE_IMAGE_REPO) $(ANSIBLE_IMAGE_PATH); \
	fi
	if ! [ -d "$(PHP_IMAGE_PATH)" ]; then \
		$(GIT) clone $(PHP_IMAGE_REPO) $(PHP_IMAGE_PATH); \
	fi
	${INFO} "Done."

run:
	@make reset

reset:
	@make clean
	@make wipe
	@make setup
	@make install
	@make init-project
	@make start
	@make test

start:
	${INFO} "Starting platform.."
	${INFO} "Starting database and waiting.."
	${CMD} $(DEV_COMPOSE_CMD) up probe
	${INFO} "Starting server.."
	${CMD} $(DEV_COMPOSE_CMD) up -d nginx
	${INFO} "Migrating.."
	${CMD} $(ARTISAN) migrate || true
	${INFO} "Done."

test:
	${INFO} "Testing.."
	${CMD} $(DEV_COMPOSE_CMD) up test
	${INFO} "Done."

tt:
	${CMD} echo "lol"

wipe:
	${INFO} "Wiping all docker containers.."
	${CMD} $(DOCKER_COMPOSE_KILL)
	${CMD} $(DOCKER_COMPOSE_RM)
	@$(DOCKER) images -q -f dangling=true | xargs -I ARGS docker rmi -f ARGS
	@$(DOCKER) volume ls -q -f dangling=true | xargs -I ARGS docker volume rm ARGS
	${INFO} "Done."