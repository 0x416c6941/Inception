# Makefile for Inception.

DC_FILE_DIR := ./srcs
DC_FILE_NAME := docker-compose.yml

.PHONY: all
all: up

.PHONY: up
up:
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

.PHONY: clean
clean: down
	@./clean.sh
