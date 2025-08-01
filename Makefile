# Makefile for Inception.

# Sourcing .env.
include ./.env

# Docker Compose file path.
DC_FILE_DIR := ./srcs
DC_FILE_NAME := docker-compose.yml

# For volume creation in 'up' recipe and removal in 'purge' recipe.
# Thanks, Gemini, for the `sed` command.
CLEAN_WP_PATH := $(shell echo $(WP_VOL_PATH) | sed -e "s/'//g" -e 's/"//g')
CLEAN_DB_PATH := $(shell echo $(DB_VOL_PATH) | sed -e "s/'//g" -e 's/"//g')

.PHONY: all
all: up

.PHONY: up
up:
	mkdir -p $(CLEAN_WP_PATH)
	mkdir -p $(CLEAN_DB_PATH)
	@docker compose -f ${DC_FILE_DIR}/${DC_FILE_NAME} up --build -d

.PHONY: stop
stop:
	@docker compose -f ${DC_FILE_DIR}/${DC_FILE_NAME} stop

.PHONY: kill
kill:
	@docker compose -f ${DC_FILE_DIR}/${DC_FILE_NAME} kill

.PHONY: down
down:
	@docker compose -f ${DC_FILE_DIR}/${DC_FILE_NAME} down

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
