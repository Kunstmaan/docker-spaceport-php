#!/bin/bash

export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

if [ "$COMPOSER" == "yes" ]; then
    cd /app
    if [ -f composer.json ]; then
        composer install  --optimize-autoloader --ignore-platform-reqs
    fi
fi

if [ "$NPM" == "yes" ]; then
    cd /app
    if [ -f package.json ]; then
        cp /app/package.json /root/
        cd /root && npm install -q
        rsync -rlzuIO --ignore-errors /root/node_modules/ /app/node_modules > /dev/null 2>&1
    fi
fi

if [ "$GEM" == "yes" ]; then
    cd /app
    if [ -f Gemfile ]; then
        bundle install
    fi
fi

if [ "$BOWER" == "yes" ]; then
    cd /app
    if [ -f bower.json ]; then
        bower install --allow-root
    fi
fi

if [ "$GULP" == "yes" ]; then
    cd /app
    if [ -f Gulpfile ]; then
        gulp build
    fi
fi

if [ "$ASSETS" == "yes" ]; then
    cd /app
    bin/console assets:install --symlink --env=docker || app/console assets:install --symlink --env=docker
fi

if [ "$ASSETIC" == "yes" ]; then
    cd /app
    bin/console assetic:dump --env=docker || app/console assetic:dump --env=docker
fi

`$1`
