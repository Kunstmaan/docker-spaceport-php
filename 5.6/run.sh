#!/bin/bash

cd /app
composer install  --optimize-autoloader --ignore-platform-reqs --env=docker
bundle install

cp /app/package.json /root/
cd /root && npm install -q
rsync -rlzuIO --ignore-errors /root/node_modules/ /app/node_modules > /dev/null 2>&1
rm -rf /root/node_modules /root/package.json
cd /app

bower install
gulp build
app/console assets:install --symlink --env=docker
app/console assetic:dump --env=docker

php-fpm5.6
