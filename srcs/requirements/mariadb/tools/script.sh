#! /bin/bash
service mariadb start
if [ ! -d /var/lib/mysql/${SQL_DATABASE} ];
then
	mysql -u root -e "CREATE DATABASE $SQL_DATABASE;"
	mysql -u root -e "CREATE USER '$SQL_USER'@'%' IDENTIFIED BY '$SQL_PASSWORD';"
	mysql -e "GRANT ALL ON $SQL_DATABASE.* TO '$SQL_USER'@'%' IDENTIFIED BY '$SQL_PASSWORD' WITH GRANT OPTION;"
	mysql -u root -e "CREATE USER '$SQL_ROOT_USER'@'localhost' IDENTIFIED BY '$SQL_ROOT_PASSWORD';"
	mysql -u root -e "FLUSH PRIVILEGES;"
fi
service mariadb stop
exec "$@"
