QUIET ?= false

RED := "\e[0;31m"
GREEN := "\e[0;32m"
DARKGREY := "\e[1;30m"
YELLOW := "\e[1;33m"
NC := "\e[0m"

INFO := @bash -c '\
	printf $(YELLOW); \
	echo "=> $$1"; \
	printf $(NC)' VALUE
  
SUCCESS := @bash -c '\
	printf $(GREEN); \
	echo "=> $$1"; \
	printf $(NC)' VALUE
  
ifeq ($(QUIET),true)
	CMD := @bash -c '\
	$$* >/dev/null; \
	' VALUE
endif

ifeq ($(QUIET),false)
	CMD := @bash -c '\
	printf $(DARKGREY); \
	echo "=> $$*"; \
	$$*; \
	printf $(NC)' VALUE
endif

BUILD_VERSION := `npm run -s getversion`
BUILD_HASH := `docker images $(APP_NAME):latest -q`