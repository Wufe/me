stop:
	@if [ $(DEVELOPMENT) == NA -a $(PRODUCTION) == NA ]; then \
		if [ $(DEFAULT_ENVIRONMENT) == development ]; then \
			make stop-development; \
		else \
			make stop-production; \
		fi \
	else \
		if [ $(DEVELOPMENT) == true ]; then \
			make stop-development; \
		fi; \
		if [ $(PRODUCTION) == true ]; then \
			make stop-production; \
		fi \
	fi

stop-development:
	${INFO} "Stopping development containers.."
	${CMD} docker-compose $(COMPOSE_DEV_FILES) -p $(APP_NAME) stop

stop-production:
	@if [ $(PORT) == NA ]; then \
		bash -c '\
			printf $(RED); \
			echo "==> PORT environment variable not set."; \
			printf $(NC); \
		'; \
		exit 2; \
	fi
	${INFO} "Stopping production containers.."
	${CMD} docker-compose $(COMPOSE_PROD_FILES) -p $(APP_NAME) stop
