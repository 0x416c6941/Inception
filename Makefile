# Makefile for Inception.

include .env

.PHONY: all
all: up

.PHONY: up
up:
	docker compose -f ${DC_FILE_DIR}/${DC_FILE_NAME} up --build -d

.PHONY: kill
kill:
	docker compose -f ${DC_FILE_DIR}/${DC_FILE_NAME} kill

.PHONY: down
down:
	docker compose -f ${DC_FILE_DIR}/${DC_FILE_NAME} down

# Let's be conservative and not delete
# unusued Docker data with `docker system prune...`
#.PHONY: clean
#clean: down
