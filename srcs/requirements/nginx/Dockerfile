# Using the latest version from previous major release.
FROM alpine:3.21.4
WORKDIR /www/

RUN apk update && apk upgrade --no-cache	\
	&& apk add --no-cache nginx
RUN mkdir -p /etc/nginx/conf.d/
COPY ./conf/conf.d/daemon.conf /etc/nginx/conf.d/

CMD ["nginx"]
