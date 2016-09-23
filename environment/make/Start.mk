start:
	@if ! [ $(WEBHOOK) == NA ]; then \
		make start-webhook; \
	else \
		if [ $(DEVELOPMENT) == NA -a $(PRODUCTION) == NA ]; then \
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
	${INFO} "Starting database.."
	@bash -c 'PORT=$(PORT) docker-compose $(COMPOSE_PROD_FILES) -p $(APP_NAME) up probe > /dev/null'
	${INFO} "Starting web server.."
	@bash -c 'PORT=$(PORT) docker-compose $(COMPOSE_PROD_FILES) -p $(APP_NAME) up -d webserver'
	${INFO} "Migrating database.."
	${CMD} docker exec -it $$(PORT=$(PORT) docker-compose $(COMPOSE_PROD_FILES) -p $(APP_NAME) ps -q app) php /app/artisan migrate --force || true
	${SUCCESS} "Production environment ready."

start-webhook:
	@if [ $(WEBHOOK_SECRET) == NA ]; then \
		bash -c '\
			printf $(RED); \
			echo "==> WEBHOOK_SECRET environment variable not set."; \
			printf $(NC); \
		'; \
		exit 2; \
	fi
	${INFO} "Starting webhook.."
	@bash -c 'WEBHOOK_SECRET=$(WEBHOOK_PORT) docker-compose -f $(WEBHOOK_COMPOSE_FILE) -p $(APP_NAME) up'