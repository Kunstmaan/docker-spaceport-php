#!/bin/bash

cd /app
composer install  --optimize-autoloader

php-fpm5.6
