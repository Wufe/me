SHELL := /bin/bash
APP_NAME ?= me

COMPOSE_FILE_DEV := environment/docker-compose/development.yml
COMPOSE_FILE_PROD := environment/docker-compose/production.yml
NODE := docker run -it --rm -v `pwd`:/app -w /app node:wheezy
COMPOSER := docker run -it --rm -v `pwd`/src:/app -w /app composer/composer

.PHONY: bundle clean install development production start stop test watch wipe

bundle:
	webpack --config /environment/prod.webpack.js

clean:
	rm -rf src/resources/assets/javascript/*
	rm -rf src/resources/assets/images/*

install:
	$(NODE) npm i
	$(NODE) /app/node_modules/.bin/typings install
	$(COMPOSER) install
	$(COMPOSER) run-script post-root-package-install
	$(COMPOSER) run-script post-create-project-cmd
	$(NODE) /app/node_modules/.bin/webpack --config /app/environment/dev.webpack.js

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
