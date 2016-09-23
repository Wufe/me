watch:
	${INFO} "Starting now webpack watch routine.."
	${CMD} $(DOCKER_RUN) --rm -w /app -v `pwd`:/app node:wheezy npm run pack:watch -s