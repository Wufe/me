development:
	@make wipe
	@make install DEVELOPMENT=true
	@make build DEVELOPMENT=true
	@make start DEVELOPMENT=true
	@if ! [ $(WATCH) == false ]; then \
		make watch; \
	fi