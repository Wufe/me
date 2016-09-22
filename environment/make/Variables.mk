APP_FOLDER := src
APP_BACKEND_FOLDER ?= $(APP_FOLDER)/backend
APP_FRONTEND_FOLDER ?= $(APP_FOLDER)/frontend

BIN_FOLDER := bin
DIST_FOLDER := dist

DEVELOPMENT_ENVIRONMENT_FILE := environment/dev.env
PRODUCTION_ENVIRONMENT_FILE := environment/prod.env

# Git repositories
ANSIBLE_IMAGE_PATH := environment/docker/images/common/ansible
ANSIBLE_IMAGE_REPO := https://github.com/Wufe/docker-ansible
PHP_IMAGE_PATH := environment/docker/images/common/php70
PHP_IMAGE_REPO := https://github.com/Wufe/docker-php70

# Docker compose files
DEV_COMMON_COMPOSE_FILE := environment/docker/compose/common.yml
DEV_APP_COMPOSE_FILE := environment/docker/compose/development.yml

PROD_COMMON_COMPOSE_FILE := environment/docker/compose/common.yml
PROD_APP_COMPOSE_FILE := environment/docker/compose/production.yml

COMPOSE_DEV_FILES := -f $(DEV_COMMON_COMPOSE_FILE) -f $(DEV_APP_COMPOSE_FILE)
COMPOSE_PROD_FILES := -f $(PROD_COMMON_COMPOSE_FILE) -f $(PROD_APP_COMPOSE_FILE)

RED := "\e[0;31m"
GREEN := "\e[0;32m"
DARKGREY := "\e[1;30m"
YELLOW := "\e[1;33m"
NC := "\e[0m"

INFO := @bash -c '\
	printf $(YELLOW); \
	echo "=> $$1"; \
	printf $(NC)' VALUE

SUCCESS := @bash -c '\
	printf $(GREEN); \
	echo "=> $$1"; \
	printf $(NC)' VALUE

ifeq ($(QUIET),true)
	CMD := @bash -c '\
	$$* >/dev/null; \
	' VALUE
endif

ifeq ($(QUIET),false)
	CMD := @bash -c '\
	printf $(DARKGREY); \
	echo "=> $$*"; \
	$$*; \
	printf $(NC)' VALUE
endif

# External port
PORT ?= NA
# Command variables
BUILD := NA
RELEASE := NA
DEVELOPMENT := NA
PRODUCTION := NA
ALL := NA
STOP := false
KILL := false
WIPE := false
REMOVE := true
WATCH := NA
DB_ROOT_PASS ?= NA
DB_NAME ?= NA
DB_USER ?= NA
DB_PASS ?= NA
MYSQL_ROOT_PASSWORD ?= NA
MYSQL_DATABASE ?= NA
MYSQL_USER ?= NA
MYSQL_PASSWORD ?= NA