#!/bin/bash

export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

if [ "$XDEBUG" == "on" ]; then
    phpenmod xdebug
fi

if [ "$XDEBUG" == "off" ]; then
    phpdismod xdebug
fi

if [ -n "$XDEBUG_HOST" ]; then
    echo "xdebug.remote_host=$XDEBUG_HOST" >> /etc/php/7.0/mods-available/xdebug.ini
fi

`$1`
