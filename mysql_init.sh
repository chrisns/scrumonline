#!/bin/bash

/usr/bin/mysqld_safe > /dev/null 2>&1 &

RET=1
while [[ RET -ne 0 ]]; do
  echo "=> Waiting for confirmation of MySQL service startup"
  sleep 5
  mysql -uroot -e "status" > /dev/null 2>&1
  RET=$?
done

mysql -uroot -e "CREATE DATABASE scrum_online"

# Create database schema
./vendor/bin/doctrine orm:schema-tool:create
./vendor/bin/doctrine orm:generate-proxies

mysqladmin shutdown