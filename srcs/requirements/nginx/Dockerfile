FROM debian:bullseye
# Update package and install
RUN apt-get update && \
	apt-get install -y nginx curl vim openssl

# store Secure connfiguration certificate and create the root directory & give permisions
#RUN mkdir -p /var/www/html/
#RUN chmod -R 755 /var/www/html/
#RUN chown -R www-data:www-data /var/www/html/

RUN   openssl req -new -newkey rsa:2048 -sha256 -days 365 -x509 -nodes -out /etc/ssl/certs/clballes.crt -keyout /etc/ssl/certs/clballes.key -subj "/C=ES/ST=Barcelona/L=Barcelona/O=clballes.42.f/OU=42/CN=clballes"

#RUN cat /etc/ssl/clballes.csr /etc/ssl/clballes.key > /etc/ssl/clballes.pem
# Copy nginx configuration file
COPY conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

CMD ["nginx", "-g","daemon off;"]
