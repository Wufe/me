build:
	@if [ $(DEVELOPMENT) == NA -a $(PRODUCTION) == NA ]; then \
		if [ $(DEFAULT_ENVIRONMENT) == development ]; then \
			make build-development; \
		else \
			make build-production; \
		fi \
	else \
		if [ $(DEVELOPMENT) == true ]; then \
			make build-development; \
		fi; \
		if [ $(PRODUCTION) == true ]; then \
			make build-production; \
		fi \
	fi

build-development:
	@make bundle DEVELOPMENT=true
	@make build-docker-images-development

build-production:
	@make build-dist
	@make bundle PRODUCTION=true
	@make build-docker-images-production
	

build-docker-images-development:
	${INFO} "Building development docker images.."
	${CMD} docker-compose $(COMPOSE_DEV_FILES) -p $(APP_NAME) build

build-docker-images-production:
	@if [ $(PORT) == NA ]; then \
		bash -c '\
			printf $(RED); \
			echo "==> PORT environment variable not set."; \
			printf $(NC); \
		'; \
		exit 2; \
	fi
	${INFO} "Building production docker images.."
	${CMD} docker-compose $(COMPOSE_PROD_FILES) -p $(APP_NAME) build --pull

build-dist:
	${INFO} "Building dist folder.."
	@if [ -d "$(DIST_FOLDER)" ]; then \
		rm -rf $(DIST_FOLDER); \
	fi
	${CMD} cp -R $(APP_BACKEND_FOLDER) $(DIST_FOLDER)
	${INFO} "Cleaning dist folder.."
	${CMD} rm -rf $(DIST_FOLDER)/resources/assets/images/*
	${CMD} rm -rf $(DIST_FOLDER)/resources/assets/javascript/*
	${INFO} "Checking production environment file.."
	@if ! [ -d "$(PRODUCTION_ENVIRONMENT_FILE)" ]; then \
		cp $(DEVELOPMENT_ENVIRONMENT_FILE) $(PRODUCTION_ENVIRONMENT_FILE); \
	fi