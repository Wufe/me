start:
	@if [ $(DEVELOPMENT) == NA -a $(PRODUCTION) == NA ]; then \
		if [ $(DEFAULT_ENVIRONMENT) == development ]; then \
			make start-development; \
		else \
			make start-production; \
		fi \
	else \
		if [ $(DEVELOPMENT) == true ]; then \
			make start-development; \
		fi; \
		if [ $(PRODUCTION) == true ]; then \
			make start-production; \
		fi \
	fi

start-development:
	${INFO} "Starting database.."
	${CMD} docker-compose $(COMPOSE_DEV_FILES) -p $(APP_NAME) up probe > /dev/null
	${INFO} "Starting web server.."
	${CMD} docker-compose $(COMPOSE_DEV_FILES) -p $(APP_NAME) up -d webserver
	${INFO} "Migrating database.."
	${CMD} docker exec -it $$(docker-compose $(COMPOSE_DEV_FILES) -p $(APP_NAME) ps -q app) php /app/artisan migrate > /dev/null || true
	${SUCCESS} "Development environment ready."

start-production:
	@if [ $(PORT) == NA ]; then \
		bash -c '\
			printf $(RED); \
			echo "==> PORT environment variable not set."; \
			printf $(NC); \
		'; \
		exit 2; \
	fi
	${INFO} "Starting database.."
	${CMD} docker-compose $(COMPOSE_PROD_FILES) -p $(APP_NAME) up probe > /dev/null
	${INFO} "Starting web server.."
	${CMD} docker-compose $(COMPOSE_PROD_FILES) -p $(APP_NAME) up -d webserver
	${INFO} "Migrating database.."
	${CMD} docker exec -it $$(docker-compose $(COMPOSE_PROD_FILES) -p $(APP_NAME) ps -q app) php /app/artisan migrate > /dev/null || true
	${SUCCESS} "Development environment ready."