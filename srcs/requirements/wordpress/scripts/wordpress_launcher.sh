#!/bin/sh

# "The latest tag is prohibited", so it also affects this?...
WORDPRESS_PAYLOAD='wordpress-6.7.2.tar.gz'
WP_CONFIG_PATH='/var/www/html/wordpress/wp-config.php'

if [ ! -d /var/www/html/wordpress ]; then
	# Getting the WordPress payload.
	wget https://wordpress.org/$WORDPRESS_PAYLOAD
	tar -xzvf $WORDPRESS_PAYLOAD -C /var/www/html/
	rm -f $WORDPRESS_PAYLOAD
	chown -R www-data:www-data /var/www/html/wordpress/
	find /var/www/html/wordpress -type d -exec chmod 755 {} \;
	find /var/www/html/wordpress -type f -exec chmod 644 {} \;
	# Preparing the wp-config.php.
	echo "<?php" > $WP_CONFIG_PATH
	echo "define( 'DB_NAME', '$SQL_DB' );" >> $WP_CONFIG_PATH
	echo "define( 'DB_USER', '$SQL_USER' );" >> $WP_CONFIG_PATH
	echo "define( 'DB_PASSWORD', '$(cat $SQL_USER_PASS_FILE_PATH)' );" >> $WP_CONFIG_PATH
	echo "define( 'DB_HOST', 'mariadb' );" >> $WP_CONFIG_PATH
	echo "define( 'DB_CHARSET', 'utf8' );" >> $WP_CONFIG_PATH
	echo "define( 'DB_COLLATE', '' );" >> $WP_CONFIG_PATH
	echo "" >> $WP_CONFIG_PATH
	curl -L https://api.wordpress.org/secret-key/1.1/salt/ >> $WP_CONFIG_PATH
	echo "" >> $WP_CONFIG_PATH
	echo "\$table_prefix = 'wp_';" >> $WP_CONFIG_PATH
	echo "" >> $WP_CONFIG_PATH
	echo "define( 'WP_DEBUG', false );" >> $WP_CONFIG_PATH
	echo "" >> $WP_CONFIG_PATH
	echo "if ( ! defined( 'ABSPATH' ) ) {" >> $WP_CONFIG_PATH
	# Using printf here, because dash
	# (or whatever else is the standard shell on Debian)
	# ignored the "-e" echo parameter.
	# And yes, the first character in the string is tab.
	printf '%s\n' "	define( 'ABSPATH', __DIR__ . '/' );" >> $WP_CONFIG_PATH
	echo "}" >> $WP_CONFIG_PATH
	echo "" >> $WP_CONFIG_PATH
	echo "require_once ABSPATH . 'wp-settings.php';" >> $WP_CONFIG_PATH
fi
# "-F" for "Ignore daemonize option."
exec /usr/sbin/php-fpm8.2 -F
