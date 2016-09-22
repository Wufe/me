include environment/make/*

# Application name
APP_NAME ?= me

DEFAULT_ENVIRONMENT ?= development

# Quiet log
QUIET ?= false

test:
	# Requires development environment up and running
	# @make development WATCH=false
	# ${INFO} "Testing.."
	# ${CMD} docker-compose $(COMPOSE_DEV_FILES) -p $(APP_NAME) up test
	# ${SUCCESS} "Done."

release:
	# To be implemented

deploy:
	# To be implemented

