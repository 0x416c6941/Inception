FROM alpine:3.21.4
WORKDIR /db

RUN apk update && apk upgrade --no-cache		\
	&& apk add --no-cache mariadb mariadb-client
COPY ./conf/mariadb-server.cnf /etc/my.cnf.d/.
RUN mkdir -p /run/mysqld
COPY ./scripts/mariadb_launcher.sh ./
RUN chmod +x ./mariadb_launcher.sh

CMD ["./mariadb_launcher.sh"]
