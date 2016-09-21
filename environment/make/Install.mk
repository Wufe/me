install:
	@if [ $(DEVELOPMENT) == NA -a $(PRODUCTION) == NA ]; then \
		if [ $(DEFAULT_ENVIRONMENT) == development ]; then \
			make install-development; \
		else \
			make install-production; \
		fi \
	else \
		if [ $(DEVELOPMENT) == true ]; then \
			make install-development; \
		fi; \
		if [ $(PRODUCTION) == true ]; then \
			make install-production; \
		fi \
	fi

install-development:
	@make install-images
	@make install-dependencies
	@make install-post-script

install-production:
	@make install-images
	@make install-dependencies
	@make install-post-script
	@make install-permissions

install-images:
	${INFO} "Downloading docker images.."
	@if ! [ -d "$(ANSIBLE_IMAGE_PATH)" ]; then \
		git clone $(ANSIBLE_IMAGE_REPO) $(ANSIBLE_IMAGE_PATH) >/dev/null; \
	fi
	@if ! [ -d "$(PHP_IMAGE_PATH)" ]; then \
		git clone $(PHP_IMAGE_REPO) $(PHP_IMAGE_PATH) >/dev/null; \
	fi

install-dependencies:
	${INFO} "Downloading NPM dependencies.."
	${CMD} docker run -it --rm -w /app -v `pwd`:/app node:wheezy npm install -s
	${CMD} docker run -it --rm -w /app -v `pwd`/$(APP_BACKEND_FOLDER):/app node:wheezy npm install -s
	${CMD} docker run -it --rm -w /app -v `pwd`/$(APP_FRONTEND_FOLDER):/app node:wheezy npm install -s
	${INFO} "Downloading composer dependencies.."
	${CMD} docker run -it --rm -w /app -v `pwd`/$(APP_BACKEND_FOLDER):/app composer/composer install

install-post-script:
	${INFO} "Executing post-install scripts.."
	${CMD} docker run -it --rm -w /app -v `pwd`/$(APP_BACKEND_FOLDER):/app composer/composer run-script post-root-package-install
	${CMD} docker run -it --rm -w /app -v `pwd`/$(APP_BACKEND_FOLDER):/app composer/composer run-script post-create-project-cmd
	
install-permissions:
	${INFO} "Changing permissions.."
	${CMD} chmod +x $(BIN_FOLDER)/*