# Using Debian GNU/Linux this time,
# since they have "php-fpm" packaged in their repos,
# whilst Alpine Linux does not.
FROM debian:12
WORKDIR /wp

# We need to separately install php-mysql to be able
# to connect to the MySQL DB w/ PHP, since it's not a dependency of "php-fpm".
RUN apt update && apt install -y wget php-fpm curl	\
	php8.2-mysql					\
	&& apt clean
COPY ./conf/php-fpm.conf /etc/php/8.2/fpm/pool.d/www.conf
COPY ./scripts/wordpress_launcher.sh .
RUN chmod +x ./wordpress_launcher.sh

CMD ["./wordpress_launcher.sh"]
