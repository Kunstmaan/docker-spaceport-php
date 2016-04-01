#!/bin/bash

export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

cd /app
composer install  --optimize-autoloader --ignore-platform-reqs

cp /app/package.json /root/
cd /root && npm install -q
rsync -rlzuIO --ignore-errors /root/node_modules/ /app/node_modules > /dev/null 2>&1
cd /app

bundle install
bower install --allow-root
gulp build
bin/console assets:install --symlink --env=docker || app/console assets:install --symlink --env=docker
bin/console assetic:dump --env=docker || app/console assetic:dump --env=docker

`$1`
