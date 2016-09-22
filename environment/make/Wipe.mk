wipe:
	@if [ $(DEVELOPMENT) == NA -a $(PRODUCTION) == NA ]; then \
		if [ $(DEFAULT_ENVIRONMENT) == development ]; then \
			make wipe-development; \
		else \
			make wipe-production; \
		fi \
	else \
		if [ $(DEVELOPMENT) == true ]; then \
			make wipe-development; \
		fi; \
		if [ $(PRODUCTION) == true ]; then \
			make wipe-production; \
		fi \
	fi
	@make wipe-dangling
	@if [ $(ALL) == true ]; then \
		make wipe-environment; \
	fi

wipe-development:
	@make kill-development
	@make remove-development

wipe-production:
	@if [ $(PORT) == NA ]; then \
		bash -c '\
			printf $(RED); \
			echo "==> PORT environment variable not set."; \
			printf $(NC); \
		'; \
		exit 2; \
	fi
	@make kill-production
	@make remove-production

wipe-dangling:
	${INFO} "Wiping docker dangling images and volumes.."
	@docker images -q -f dangling=true | xargs -I ARGS docker rmi -f ARGS || true
	@docker volume ls -q -f dangling=true | xargs -I ARGS docker volume rm ARGS || true

wipe-environment:
	${INFO} "Wiping folders and environment.."
	${CMD} rm -rf $(ANSIBLE_IMAGE_PATH)
	${CMD} rm -rf $(PHP_IMAGE_PATH)
	${CMD} rm -rf mysql_data
	${CMD} rm -rf node_modules
	${CMD} rm -rf src/backend/.env
	${CMD} rm -rf src/backend/node_modules
	${CMD} rm -rf src/backend/vendor
	${CMD} rm -rf src/backend/public/assets/javascript/*bundle.js*
	${CMD} rm -rf src/backend/public/assets/javascript/*chunk.js*
	${CMD} rm -rf src/backend/resources/assets/javascript/*bundle.js*
	${CMD} rm -rf src/backend/resources/assets/javascript/*chunk.js*
	${CMD} rm -rf src/frontend/node_modules