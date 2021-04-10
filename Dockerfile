FROM debian:buster

RUN apt-get update && apt-get upgrade

RUN apt-get -y install php7.3 php-mysql php-fpm php-cli php-mbstring php-xml

RUN	apt-get -y install nginx openssl wget

RUN apt-get -y install mariadb-server nano

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048\
 -keyout /etc/ssl/private/nginx.key -out /etc/ssl/certs/nginx.crt -subj\
  "/C=RU/ST=Moscow/L=Moscow/O=Romashka/OU=school21/emailAddress=lortrem@mail.ru"

RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.1.0/phpMyAdmin-5.1.0-all-languages.tar.gz
RUN	tar -xf phpMyAdmin-5.1.0-all-languages.tar.gz

RUN	rm -rf phpMyAdmin-5.1.0-all-languages.tar.gz
RUN	mv phpMyAdmin-5.1.0-all-languages /var/www/html/phpmyadmin

COPY ./srcs/config.inc.php /var/www/html/phpmyadmin
COPY ./srcs/nginx.conf /etc/nginx/sites-available/default

RUN wget https://ru.wordpress.org/latest-ru_RU.tar.gz
RUN	tar -xf latest-ru_RU.tar.gz

RUN	rm -rf latest-ru_RU.tar.gz
RUN	mv wordpress /var/www/html

COPY ./srcs/wp-config.php var/www/html/wordpress/wp-config.php
COPY ./srcs/run.sh .
COPY ./srcs/createDB.sql .
COPY ./srcs/autoindex.sh .
CMD bash run.sh

#docker system prune -a -f //чистим