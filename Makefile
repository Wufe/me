include environment/make/Variables.mk
include environment/make/Wipe.mk
include environment/make/Kill.mk
include environment/make/Remove.mk

# Application name
APP_NAME ?= me

DEFAULT_ENVIRONMENT ?= development

# Application external port
PORT ?= NA

# Quiet log
QUIET ?= false

.PHONY: install development start test build release deploy wipe watch run

install:
	@make install-images
	@make install-dependencies
	@make install-post
	@make build-frontend
	@make build-images DEVELOPMENT=true
	${SUCCESS} "Done."

# build stage will create a "dist" folder, ignored from git repo
# will copy all the things from the source code ( after dependencies installed )
# will bundle the frontend with production environment
# will create environment file for laravel
build:
	@if [ $(PORT) == NA ]; then \
		echo "PORT environment variable not set."; \
		exit 2; \
	fi
	# @make wipe ALL=true
	# @make install-images
	# @make install-dependencies
	# @make install-post
	# @make build-frontend
	@make build-images RELEASE=true


build-images:
	@if [ $(DEVELOPMENT) == NA -a $(RELEASE) == NA ]; then \
		make build-images-development; \
	else \
		if [ $(DEVELOPMENT) == true ]; then \
			make build-images-development; \
		else \
			if [ $(RELEASE) == true ]; then \
				make build-images-release; \
			fi \
		fi \
	fi

build-frontend:
	${INFO} "Building frontend using webpack.."
	${CMD} docker run -it --rm -w /app -v `pwd`:/app node:wheezy npm run pack -s

build-frontend-development: # or bundle-frontend-development

build-frontend-production:  # or bundle-frontend-production



build-images-development:
	${INFO} "Building development docker images.."
	${CMD} docker-compose $(COMPOSE_DEV_FILES) -p $(APP_NAME) build

build-images-release:
	${INFO} "Building release docker images.."
	${CMD} docker-compose $(COMPOSE_PROD_FILES) -p $(APP_NAME) build --pull

install-images:
	${INFO} "Downloading docker images.."
	@if ! [ -d "$(ANSIBLE_IMAGE_PATH)" ]; then \
		git clone $(ANSIBLE_IMAGE_REPO) $(ANSIBLE_IMAGE_PATH) >/dev/null; \
	fi
	@if ! [ -d "$(PHP_IMAGE_PATH)" ]; then \
		git clone $(PHP_IMAGE_REPO) $(PHP_IMAGE_PATH) >/dev/null; \
	fi

install-dependencies:
	${INFO} "Downloading NPM dependencies.."
	${CMD} docker run -it --rm -w /app -v `pwd`:/app node:wheezy npm install -s
	${CMD} docker run -it --rm -w /app -v `pwd`/$(APP_BACKEND_FOLDER):/app node:wheezy npm install -s
	${CMD} docker run -it --rm -w /app -v `pwd`/$(APP_FRONTEND_FOLDER):/app node:wheezy npm install -s
	${INFO} "Downloading composer dependencies.."
	${CMD} docker run -it --rm -w /app -v `pwd`/$(APP_BACKEND_FOLDER):/app composer/composer install

install-post:
	${INFO} "Executing post-install scripts.."
	${CMD} docker run -it --rm -w /app -v `pwd`/$(APP_BACKEND_FOLDER):/app composer/composer run-script post-root-package-install
	${CMD} docker run -it --rm -w /app -v `pwd`/$(APP_BACKEND_FOLDER):/app composer/composer run-script post-create-project-cmd
	${INFO} "Changing permissions.."
	${CMD} chmod +x $(BIN_FOLDER)/*

development:
	@if [ $(STOP) == false -a $(KILL) == false -a $(WIPE) == false ]; then \
		make development-start WATCH=$(WATCH); \
	else \
		if [ $(WIPE) == true ]; then \
			make development-wipe; \
		else \
			if [ $(KILL) == true ]; then \
				make development-kill; \
				if [ $(REMOVE) == true ]; then \
					make development-remove; \
				fi \
			else \
				if [ $(STOP) == true ]; then \
					make development-stop; \
					if [ $(REMOVE) == true ]; then \
						make development-remove; \
					fi \
				fi \
			fi \
		fi \
	fi
	
development-start:
	${INFO} "Starting database.."
	${CMD} docker-compose $(COMPOSE_DEV_FILES) -p $(APP_NAME) up probe > /dev/null
	${INFO} "Starting web server.."
	${CMD} docker-compose $(COMPOSE_DEV_FILES) -p $(APP_NAME) up -d nginx
	${INFO} "Migrating database.."
	${CMD} docker exec -it $$(docker-compose $(COMPOSE_DEV_FILES) -p $(APP_NAME) ps -q php) php /app/artisan migrate > /dev/null || true
	${SUCCESS} "Development environment ready."
	@if [ $(WATCH) == true ]; then \
		make watch; \
	fi

development-stop:
	${INFO} "Stopping containers.."
	${CMD} docker-compose $(COMPOSE_DEV_FILES) -p $(APP_NAME) stop

development-kill:
	${INFO} "Killing containers.."
	${CMD} docker-compose $(COMPOSE_DEV_FILES) -p $(APP_NAME) kill

development-remove:
	${INFO} "Removing containers.."
	${CMD} docker-compose $(COMPOSE_DEV_FILES) -p $(APP_NAME) rm -f -v

development-wipe:
	@make development-kill
	@make development-remove

start:
	@if [ $(DEFAULT_ENVIRONMENT) == development ]; then \
		make development; \
	fi

test:
	# Requires development environment up and running
	@make development WATCH=false
	${INFO} "Testing.."
	${CMD} docker-compose $(COMPOSE_DEV_FILES) -p $(APP_NAME) up test
	${SUCCESS} "Done."

# TODO: Check if BUILD=true ( true by default ). It it is true, then build.
release:
	@if [ $(BUILD) == true -o $(BUILD) == NA ]; then \
		make build; \
	fi
	${INFO} "Starting database.."
	${CMD} docker-compose $(COMPOSE_PROD_FILES) -p $(APP_NAME) up probe > /dev/null
	${INFO} "Starting web server.."
	${CMD} docker-compose $(COMPOSE_PROD_FILES) -p $(APP_NAME) up -d nginx
	${INFO} "Migrating database.."
	${CMD} docker exec -it $$(docker-compose $(COMPOSE_PROD_FILES) -p $(APP_NAME) ps -q php) php /app/artisan migrate > /dev/null || true
	${SUCCESS} "Release environment ready."

release-stop:
	${INFO} "Stopping containers.."
	${CMD} docker-compose $(COMPOSE_PROD_FILES) -p $(APP_NAME) stop

release-kill:
	${INFO} "Killing containers.."
	${CMD} docker-compose $(COMPOSE_PROD_FILES) -p $(APP_NAME) kill

release-remove:
	${INFO} "Removing containers.."
	${CMD} docker-compose $(COMPOSE_PROD_FILES) -p $(APP_NAME) rm -f -v

release-wipe:
	@if [ $(PORT) == NA ]; then \
		bash -c '\
			printf $(RED); \
			echo "==> PORT environment variable not set."; \
			printf $(NC); \
		'; \
		exit 2; \
	fi
	@make release-kill
	@make release-remove

deploy:
	# To be implemented

watch:
	${INFO} "Starting now webpack routine.."
	${CMD} docker run -it --rm -w /app -v `pwd`:/app node:wheezy npm run pack:watch -s

reset:
	@make run

run:
	${INFO} "Running all suite of development commands.."
	@make wipe
	@make install
	@make development WATCH=false
	@make test

