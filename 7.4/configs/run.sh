#!/bin/bash

export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

if [ "$XDEBUG" == "on" ]; then
    phpenmod xdebug
fi

if [ "$XDEBUG" == "off" ]; then
    phpdismod xdebug
fi

`$1`
