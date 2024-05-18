FROM debian:bullseye

RUN apt update && apt upgrade

RUN apt-get install -y\
	wget \
	php\
	php-fpm\
	php-mysql\
	mariadb-client\
	curl

RUN mkdir -p /run/php/
RUN chmod 755 /run/php/

#Installing CLI Wordpress for better managment
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

# Configure PHP-FPM to listen 9000
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d

#Setup wp own script
COPY ./tools/wp-setup.sh /usr/local/bin
RUN chmod +x /usr/local/bin/wp-setup.sh

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/wp-setup.sh"]

# CMD to start wp in the foreground
#CMD ["php-fpm7.4", "-F"]

