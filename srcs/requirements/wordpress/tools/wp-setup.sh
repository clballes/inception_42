#!/bin/sh

echo "Starting the WordPress configuration..."

# Check if wp-config.php exists
if [ ! -f "/var/www/html/wp-config.php" ];
then
    cd /var/www/html

    wp core download --allow-root
    # Create the wp-config.php file using wp-cli with default values
	wp config create --allow-root \
	    --dbname=$SQL_DATABASE \
	    --dbuser=$SQL_USER \
	    --dbpass=$SQL_PASSWORD \
	    --dbhost=$SQL_HOST
	
	wp core install --url=$WP_DOMAIN \
	    --title=$WP_TITLE --admin_user=$WP_ADMIN \
	    --admin_password=$WP_ADMIN_PASSWORD\
	    --admin_email=$WP_EMAIL --allow-root

	wp user create $WP_USER_NAME $WP_USER_EMAIL \
		--user_pass=$WP_USER_PASSWORD --role=editor --allow-root


else
    echo "WordPress configuration already completed. Skipping..."

fi

php-fpm7.4 -F
