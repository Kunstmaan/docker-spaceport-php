#!/bin/bash

cd /app
composer install  --optimize-autoloader --ignore-platform-reqs

php-fpm5.6
