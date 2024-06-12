FROM debian:bullseye

RUN apt-get update -y && \
	apt-get upgrade -y && \
	apt-get install mariadb-server -y

#configuration file
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN mkdir -p /var/run/mysqld \
	&& chown -R mysql:mysql /var/run/mysqld \
	&& chmod 2777 /var/run/mysqld

# script handling to start mysql
COPY ./tools/script.sh /usr/local/bin
RUN chmod +x /usr/local/bin/script.sh
ENTRYPOINT ["/usr/local/bin/script.sh" ]

#expose port
EXPOSE 3306

CMD ["mariadbd"]
