From php:7.0-apache
Run apt-get update && apt-get upgrade -y
RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli
Run apt-get install vim -y
Copy index.php /var/www/html
expose 80