watch:
	${INFO} "Starting now webpack watch routine.."
	${CMD} docker run --rm -w /app -v `pwd`:/app node:wheezy npm run pack:watch -s