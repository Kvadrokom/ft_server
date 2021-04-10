service php7.3-fpm start
service mysql start
mysql < createDB.sql
#rm /var/www/html/index.nginx-debian.html 
service nginx start
sleep infinity