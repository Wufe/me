remove:
	@if [ $(DEVELOPMENT) == NA -a $(PRODUCTION) == NA ]; then \
		if [ $(DEFAULT_ENVIRONMENT) == development ]; then \
			make remove-development; \
		else \
			make remove-production; \
		fi \
	else \
		if [ $(DEVELOPMENT) == true ]; then \
			make remove-development; \
		fi; \
		if [ $(PRODUCTION) == true ]; then \
			make remove-production; \
		fi \
	fi

remove-development:
	${INFO} "Removing development containers.."
	${CMD} docker-compose $(COMPOSE_DEV_FILES) -p $(APP_NAME) rm -f -v

remove-production:
	@if [ $(PORT) == NA ]; then \
		bash -c '\
			printf $(RED); \
			echo "==> PORT environment variable not set."; \
			printf $(NC); \
		'; \
		exit 2; \
	fi
	${INFO} "Removing production containers.."
	${CMD} docker-compose $(COMPOSE_PROD_FILES) -p $(APP_NAME) rm -f -v