# Makefile for Inception.

# Sourcing .env.
include ./.env

# Docker Compose file path.
DC_FILE_DIR := ./srcs
DC_FILE_NAME := docker-compose.yml

.PHONY: all
all: up

.PHONY: up
up:
	@mkdir -p $(WP_VOL_PATH)
	@mkdir -p $(DB_VOL_PATH)
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

.PHONY: purge
purge: clean
	rm -rf $(WP_VOL_PATH)
	rm -rf $(DB_VOL_PATH)
