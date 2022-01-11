# build scrumonline
FROM php:7.4.27-cli-alpine@sha256:8c03f1302082a28ad999aeb3ca7ac6836e31218a824fc7dd829a9e1aaf7ee1d6 as builder
COPY scrumonline /scrumonline
RUN wget https://raw.githubusercontent.com/composer/getcomposer.org/master/web/installer -O - -q | php --
RUN php composer.phar install -n -d /scrumonline
RUN touch /scrumonline/src/sponsors.php
RUN mv /scrumonline/src/sample-config.php /scrumonline/src/config.php
COPY config.php /tmp
RUN cat /tmp/config.php >> /scrumonline/src/config.php
COPY mysql_init.sh /scrumonline/

# build the web frontend
FROM php:7.4.27-apache@sha256:729ad01c7d8e10fd992a6d4f3eb05dce3fb69bdf5c4fb4a9de4be4f4f5ae4dcc
ENV DB_NAME=scrum_online
ENV DB_USER=root
ENV DB_PASS=passwd
ENV DB_HOST=127.0.0.1
ENV HOST="http://localhost:80"

RUN a2enmod rewrite

RUN docker-php-ext-install pdo_mysql

WORKDIR /scrumonline

COPY --from=builder /scrumonline /scrumonline 

RUN rm -r /var/www/html && \
  ln -s /scrumonline/src/ /var/www/html
