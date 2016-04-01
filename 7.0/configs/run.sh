#!/bin/bash

export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

cd /app
if [ -f composer.json ]; then
    composer install  --optimize-autoloader --ignore-platform-reqs
fi

if [ -f package.json ]; then
    cp /app/package.json /root/
    cd /root && npm install -q
    rsync -rlzuIO --ignore-errors /root/node_modules/ /app/node_modules > /dev/null 2>&1
fi
cd /app

if [ -f Gemfile ]; then
    bundle install
fi
if [ -f bower.json ]; then
    bower install --allow-root
fi
if [ -f Gulpfile ]; then
    gulp build
fi
bin/console assets:install --symlink --env=docker || app/console assets:install --symlink --env=docker
bin/console assetic:dump --env=docker || app/console assetic:dump --env=docker

`$1`
