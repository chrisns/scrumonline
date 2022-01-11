# build scrumonline
FROM php:7.4.11-cli-alpine@sha256:407ec4b5b52ec52bbf250fb996fc0910f1317d757dbab38aa5f45e332c953a6a as builder
COPY scrumonline /scrumonline
RUN wget https://raw.githubusercontent.com/composer/getcomposer.org/master/web/installer -O - -q | php --
RUN php composer.phar install -n -d /scrumonline
RUN touch /scrumonline/src/sponsors.php
RUN mv /scrumonline/src/sample-config.php /scrumonline/src/config.php
COPY config.php /tmp
RUN cat /tmp/config.php >> /scrumonline/src/config.php
COPY mysql_init.sh /scrumonline/

# build the web frontend
FROM php:7.4.19-apache@sha256:95b36612c935bde6a41a7ed11b706c8abc99d8f85e2c17854168a40167da6537
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
