#!/bin/bash

echo "starting mariadb server ..."

service mariadb start;
# Check the status of MariaDB service
#if service mariadb status >/dev/null; then
#    echo "MariaDB started successfully."
#else
#    echo "Failed to start MariaDB."
if [ ! -d /var/lib/mysql/${SQL_DATABASE} ];
then
	mysql -u root -e "CREATE DATABASE IF NOT EXISTS $SQL_DATABASE;"
	mysql -u root -e "CREATE USER IF NOT EXISTS '$SQL_USER'@'%'IDENTIFIED BY '$SQL_PASSWORD';"
	mysql -e "GRANT ALL ON $SQL_DATABASE.* TO '$SQL_USER'@'%'IDENTIFIED BY '$SQL_PASSWORD' WITH GRANT OPTION;"
	mysql -u root -e "CREATE USER '$SQL_ROOT_USER'@'localhost' IDENTIFIED BY '$SQL_ROOT_PASSWORD';"
	mysql -u root -e "FLUSH PRIVILEGES;"
fi

service mariadb stop;
exec "$@"
