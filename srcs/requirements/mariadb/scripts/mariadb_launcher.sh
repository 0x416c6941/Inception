#!/bin/sh

if [ ! -d "/var/lib/mysql/mysql" ]; then
	# Initializing MariaDB data directory.
	mariadb-install-db --user=root		\
		--datadir=/var/lib/mysql
	# Removing PID and socket files to be safe
	# before running `mariadbd`.
	rm -f /run/mysqld/mysqld.pid
	rm -f /run/mysqld/mysqld.sock
	mariadbd &
	# Waiting for the MariaDB server to initialize.
	while ! (mariadb-admin ping --silent); do
		sleep 1
	done
	mariadb -u root -e "CREATE DATABASE IF NOT EXISTS \`$SQL_DB\`;"
	mariadb -u root -e "CREATE USER IF NOT EXISTS \`$SQL_ADMIN\`@'%' IDENTIFIED BY '$(cat $SQL_ADMIN_PASS_FILE_PATH)';"
	mariadb -u root -e "GRANT ALL PRIVILEGES ON \`$SQL_DB\`.* TO \`$SQL_ADMIN\`@'%' WITH GRANT OPTION;"
	mariadb -u root -e "CREATE USER IF NOT EXISTS \`$SQL_USER\`@'%' IDENTIFIED BY '$(cat $SQL_USER_PASS_FILE_PATH)';"
	# Recommeneded WordPress privileges (according to Google Gemini 2.5 Pro).
	mariadb -u root -e "GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, ALTER, DROP, INDEX, REFERENCES ON \`$SQL_DB\`.* TO \`$SQL_USER\`@'%';"
	mariadb -u root -e "FLUSH PRIVILEGES;"
	mariadb-admin -u root shutdown
	# Waiting for the MariaDB server to shut down.
	while (mariadb-admin ping --silent); do
		sleep 1
	done
fi
# Removing PID and socket files again to be safe.
rm -f /run/mysqld/mysqld.pid
rm -f /run/mysqld/mysqld.sock
exec mariadbd
