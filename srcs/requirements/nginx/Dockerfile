# Using the latest version from previous major release.
FROM alpine:3.21.4
WORKDIR /www/

RUN apk update && apk upgrade --no-cache	\
	&& apk add --no-cache nginx
