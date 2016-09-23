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
	@make build-remove-dist

build-remove-dist:
	${INFO} "Deleting dist folder.."
	@if [ -d "$(DIST_FOLDER)" ]; then \
		rm -rf $(DIST_FOLDER); \
	fi
	

build-docker-images-development:
	${INFO} "Building development docker images.."
	${CMD} docker-compose $(COMPOSE_DEV_FILES) -p $(APP_NAME) build

build-docker-images-production:
	${INFO} "Building production docker images.."
	@bash -c 'PORT=$(PORT) DB_ROOT_PASS=$(DB_ROOT_PASS) DB_USER=$(DB_USER) DB_NAME=$(DB_NAME) DB_PASS=$(DB_PASS) docker-compose $(COMPOSE_PROD_FILES) -p $(APP_NAME) build --pull'

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
	@if ! [ -f "$(PRODUCTION_ENVIRONMENT_FILE)" ]; then \
		cp src/backend/.env.example $(PRODUCTION_ENVIRONMENT_FILE); \
	fi
	${INFO} "Applying production environment.."
	${CMD} cp $(PRODUCTION_ENVIRONMENT_FILE) $(DIST_FOLDER)/.env
	${INFO} "Creating new application key.."
	${CMD} docker run --rm -w /app -v `pwd`/$(DIST_FOLDER):/app composer/composer run-script post-create-project-cmd