#!/bin/bash

cd /app
composer install  --optimize-autoloader

php-fpm7.0
