production:
	@make wipe ALL=true
	@make install PRODUCTION=true
	@make build PRODUCTION=true
	@make start PRODUCTION=true WEBHOOK=false