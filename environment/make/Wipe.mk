.PHONY: wipe

wipe:
	@if [ $(DEVELOPMENT) == NA -a $(PRODUCTION) == NA ]; then \
		if [ $(DEFAULT_ENVIRONMENT) == development ]; then \
			make wipe-development; \
		else \
			make wipe-production; \
		fi \
	else \
		if [ $(DEVELOPMENT) == true ]; then \
			make wipe-development; \
		fi \
		if [ $(PRODUCTION) == true ]; then \
			make wipe-production; \
		fi \
	fi
	@make wipe-dangling
	@if [ $(ALL) == true ]; then \
		make wipe-environment; \
	fi

wipe-development:
	@make kill-development
	@make remove-development

wipe-production:
	@make kill-production
	@make remove-production

wipe-dangling:

wipe-environment: