#!/bin/bash

cd /app
composer install  --optimize-autoloader --ignore-platform-reqs --env=docker
bundle install
npm install
bower install
gulp build
app/console assets:install --symlink --env=docker
app/console assetic:dump --env=docker

php5-fpm
