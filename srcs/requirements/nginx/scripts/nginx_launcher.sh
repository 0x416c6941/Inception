#!/bin/sh

# SSL certificate.
if [ ! -f /etc/nginx/ssl/asagymba.42.fr.crt ]; then
	mkdir -p /etc/nginx/ssl
	cp "${SSL_CRT_PATH}" /etc/nginx/ssl/asagymba.42.fr.crt
fi
# SSL key.
if [ ! -f /etc/nginx/ssl/asagymba.42.fr.key ]; then
	mkdir -p /etc/nginx/ssl
	cp "${SSL_KEY_PATH}" /etc/nginx/ssl/asagymba.42.fr.key
fi
exec nginx
