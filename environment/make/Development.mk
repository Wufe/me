development:
	@make install DEVELOPMENT=true
	@make build DEVELOPMENT=true
	@make start DEVELOPMENT=true
	@if [ $(WATCH) == true ]; then \
		make watch; \
	fi