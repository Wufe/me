SHELL := /bin/bash

APP_NAME ?= wufe-me

include environment/make/Utils.mk

COMPOSE_FILE_DEV := environment/docker-compose/development.yml
COMPOSE_FILE_PROD := environment/docker-compose/production.yml
NODE := docker run -it --rm -v `pwd`:/app -w /app node:wheezy
COMPOSER := docker run -it --rm -v `pwd`/src:/app -w /app composer/composer

.PHONY: build clean install development production start stop test watch wipe

hash:
	@echo $(BUILD_HASH)

build:
	${INFO} "Cleaning.."
	${CMD} make clean
	${INFO} "Building frontend stuff.."
	${CMD} webpack --config environment/prod.webpack.js
	${INFO} "Acquiring external vendor code.."
	${CMD} mkdir -p src/resources/assets/vendor/bootstrap
	${CMD} cp node_modules/bootstrap/dist/css/bootstrap.min.css src/resources/assets/vendor/bootstrap/
	${CMD} cp node_modules/bootstrap/dist/js/bootstrap.min.js src/resources/assets/vendor/bootstrap/
	${CMD} mkdir -p src/resources/assets/vendor/jquery
	${CMD} cp node_modules/jquery/dist/jquery.min.js src/resources/assets/vendor/jquery/
	${CMD} mkdir -p src/resources/assets/vendor/react
	${CMD} cp node_modules/react/dist/react.min.js src/resources/assets/vendor/react/
	${CMD} mkdir -p src/resources/assets/vendor/react-dom
	${CMD} cp node_modules/react-dom/dist/react-dom.min.js src/resources/assets/vendor/react-dom/
	${INFO} "Removing dist folder.."
	@if [ -d "dist" ]; then \
		rm -rf dist; \
	fi
	${INFO} "Creating new dist folders.."
	${CMD} mkdir -p dist && mkdir -p dist
	${INFO} "Copying source code to dist folder.."
	${CMD} cp -R src dist/app
	${INFO} "Moving assets.."
	${CMD} mv dist/app/resources/assets dist/assets
	${INFO} "Updating version.."
	${CMD} npm version --no-git-tag-version minor 
	${INFO} "Building docker image.."
	${CMD} docker build -f environment/docker-images/app/Dockerfile -t $(APP_NAME):$(BUILD_VERSION) -t $(APP_NAME):latest .
	${SUCCESS} "Successfully built $(BUILD_HASH) version $(BUILD_VERSION)."
	

clean:
	rm -rf src/resources/assets/javascript/*
	rm -rf src/resources/assets/images/*
	rm -rf src/resources/assets/vendor/*
	rm -rf src/database/database.sqlite

install:
	$(NODE) npm i
	$(NODE) /app/node_modules/.bin/typings install
	$(COMPOSER) install
	$(COMPOSER) run-script post-root-package-install
	$(COMPOSER) run-script post-create-project-cmd
	$(NODE) /app/node_modules/.bin/webpack --config /app/environment/dev.webpack.js
	$(NODE) npm i bootstrap jquery react react-dom
	mkdir -p src/resources/assets/vendor/bootstrap
	cp node_modules/bootstrap/dist/css/bootstrap.min.css src/resources/assets/vendor/bootstrap/
	cp node_modules/bootstrap/dist/js/bootstrap.min.js src/resources/assets/vendor/bootstrap/
	mkdir -p src/resources/assets/vendor/jquery
	cp node_modules/jquery/dist/jquery.min.js src/resources/assets/vendor/jquery/
	mkdir -p src/resources/assets/vendor/react
	cp node_modules/react/dist/react.js src/resources/assets/vendor/react/
	mkdir -p src/resources/assets/vendor/react-dom
	cp node_modules/react-dom/dist/react-dom.js src/resources/assets/vendor/react-dom/

development:
	@make start
	@make watch

production:
	$(NODE) /app/node_modules/.bin/webpack --config /app/environment/prod.webpack.js
	docker-compose -f $(COMPOSE_FILE_PROD) -p $(APP_NAME) up -d webserver

start:
	docker-compose -f $(COMPOSE_FILE_DEV) -p $(APP_NAME) up -d webserver

stop:
	docker-compose -f $(COMPOSE_FILE_DEV) -p $(APP_NAME) ps -q | xargs docker stop --
	docker-compose -f $(COMPOSE_FILE_PROD) -p $(APP_NAME) ps -q | xargs docker stop --

test:
	cd src && phpunit tests

watch:
	$(NODE) /app/node_modules/.bin/webpack --config /app/environment/dev.webpack.js --watch

wipe:
	docker-compose -f $(COMPOSE_FILE_DEV) -p $(APP_NAME) ps -q | xargs docker rm -f --
	docker-compose -f $(COMPOSE_FILE_PROD) -p $(APP_NAME) ps -q | xargs docker rm -f --
