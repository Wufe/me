bundle:
	@if [ $(DEVELOPMENT) == NA -a $(PRODUCTION) == NA ]; then \
		if [ $(DEFAULT_ENVIRONMENT) == development ]; then \
			make bundle-development; \
		else \
			make bundle-production; \
		fi \
	else \
		if [ $(DEVELOPMENT) == true ]; then \
			make bundle-development; \
		fi; \
		if [ $(PRODUCTION) == true ]; then \
			make bundle-production; \
		fi \
	fi

bundle-development:
	${INFO} "Building development frontend using webpack.."
	${CMD} docker run -it --rm -w /app -v `pwd`:/app node:wheezy npm run pack:development -s

bundle-production:
	${INFO} "Building production frontend using webpack.."
	${CMD} docker run -it --rm -w /app -v `pwd`:/app node:wheezy npm run pack:production -s