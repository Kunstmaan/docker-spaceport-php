#!/bin/bash

cd /app
composer install  --optimize-autoloader --ignore-platform-reqs
bundle install
npm install
bower install
gulp build
app/console assets:install --symlink
app/console assetic:dump

php-fpm5.6
