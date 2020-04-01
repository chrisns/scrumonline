FROM chrisns/scrumonline:latest as original
# no otherway to remove the volumes, sad face!
FROM scratch
COPY --from=original / /

WORKDIR /var/www/scrumonline
COPY scrumonline/ ./
RUN composer install -nd /var/www/scrumonline

COPY mysql.cnf /etc/mysql/conf.d/mysql-hack.cnf
RUN cp src/sample-config.php src/config.php
RUN echo '$host = $_ENV["HOST"];' >> src/config.php

RUN /utils/mysql_init.sh && mysqladmin shutdown && echo "" > /utils/mysql_init.sh

CMD /utils/run.sh

