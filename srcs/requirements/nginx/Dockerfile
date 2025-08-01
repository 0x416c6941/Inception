FROM alpine:3.21.4
WORKDIR /www/

RUN apk update && apk upgrade --no-cache	\
	&& apk add --no-cache nginx
RUN mkdir -p /etc/nginx/conf.d/
COPY ./conf/conf.d/daemon.conf /etc/nginx/conf.d/.
RUN rm -f /etc/nginx/http.d/default.conf
COPY ./conf/http.d/server.conf /etc/nginx/http.d/default.conf
COPY ./scripts/nginx_launcher.sh ./
RUN chmod +x ./nginx_launcher.sh

CMD ["./nginx_launcher.sh"]
