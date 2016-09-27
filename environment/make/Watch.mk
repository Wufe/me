watch:
	${INFO} "Starting now webpack watch routine.."
	${CMD} $(DOCKER_RUN) -it --rm -w /app -v `pwd`:/app node:wheezy npm run pack:watch -s