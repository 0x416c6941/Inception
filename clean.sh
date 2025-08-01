#!/bin/sh
#
# Clean-up script to remove Docker images, volumes and networks
# used in the Docker pod created by `make` / `make up` / `make all`.
#
# Please note that we go the conservative way without using
# `docker system prune...`, therefore dangling images will not be removed.

NAME_PREFIX="srcs"

IMAGE_IDS=$(docker images --filter reference="${NAME_PREFIX}-*"		\
	--format '{{.ID}}')
NETWORK_IDS=$(docker network ls --filter name="${NAME_PREFIX}_*"	\
	--format '{{.ID}}')

# Images.
if [ -n "${IMAGE_IDS}" ]; then
	docker rmi ${IMAGE_IDS}
fi
# Networks.
if [ -n "${NETWORK_IDS}" ]; then
	docker network rm ${NETWORK_IDS}
fi
