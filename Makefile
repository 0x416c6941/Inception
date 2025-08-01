# Makefile for Inception.

# Sourcing "env".
include ./srcs/env

# For volume creation in 'up' recipe and removal in 'purge' recipe.
# Thanks, Gemini, for the `sed` command.
CLEAN_WP_PATH := $(shell echo $(WP_VOL_PATH) | sed -e "s/'//g" -e 's/"//g')
CLEAN_DB_PATH := $(shell echo $(DB_VOL_PATH) | sed -e "s/'//g" -e 's/"//g')

# Docker Compose command.
DC_CMD := docker compose -f ./srcs/docker-compose.yml --env-file ./srcs/env

.PHONY: all
all: up

.PHONY: up
up:
	@mkdir -p $(CLEAN_WP_PATH)
	@mkdir -p $(CLEAN_DB_PATH)
	@$(DC_CMD) up --build -d

.PHONY: build
build:
	@mkdir -p $(CLEAN_WP_PATH)
	@mkdir -p $(CLEAN_DB_PATH)
	@$(DC_CMD) build

.PHONY: stop
stop:
	@$(DC_CMD) stop

.PHONY: kill
kill:
	@$(DC_CMD) kill

.PHONY: down
down:
	@$(DC_CMD) down

# Clean images, volumes and networks created in "up" recipe.
.PHONY: clean
clean: down
	@./clean.sh

# XXX: This purges the Docker volume source!
# Only run when you'd like to completely reset the Docker pod state.
.PHONY: purge
purge: clean
	rm -rf $(CLEAN_WP_PATH)
	rm -rf $(CLEAN_DB_PATH)
