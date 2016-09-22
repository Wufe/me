watch:
	${INFO} "Starting now webpack watch routine.."
	${CMD} docker run -it --rm -w /app -v `pwd`:/app node:wheezy npm run pack:watch -s