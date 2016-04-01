FROM ubuntu:trusty

ENV DEBIAN_FRONTEND noninteractive

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E5267A6C

RUN echo 'deb http://ppa.launchpad.net/ondrej/php/ubuntu trusty main' >> /etc/apt/sources.list && \
    apt-get -y -qq update && \
    apt-get -y -qq install git unzip php7.0-fpm php7.0-cli php-pear curl php7.0-curl php7.0-intl php-imagick php7.0-mysqlnd php7.0-imap php7.0-gd php7.0-json php7.0-xmlrpc php7.0-xsl php7.0-mcrypt php7.0-mbstring php-apcu php-memcached && \
    mkdir -p /run/php/ && \
    apt-get -y -qq install build-essential nodejs bundler npm && \
    ln -sf /usr/bin/nodejs /usr/bin/node && \
    npm install -g bower gulp uglify-js uglifycss && \
    apt-get -y -qq autoremove && \
    apt-get -y -qq clean && \
    rm -rf /var/lib/apt/lists/*

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    composer global require hirak/prestissimo

RUN echo Europe/Brussels > /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata

RUN locale-gen nl_BE && \
    locale-gen fr_BE && \
    locale-gen en_GB && \
    locale-gen es_ES && \
    locale-gen nl_NL && \
    locale-gen fr_FR && \
    locale-gen en_US && \
    locale-gen nl_BE.UTF-8 && \
    locale-gen fr_BE.UTF-8 && \
    locale-gen en_GB.UTF-8 && \
    locale-gen es_ES.UTF-8 && \
    locale-gen nl_NL.UTF-8 && \
    locale-gen fr_FR.UTF-8 && \
    locale-gen en_US.UTF-8

COPY ./configs/kunstmaan.ini /etc/php/7.0/mods-available/kunstmaan.ini
RUN phpenmod kunstmaan

COPY ./configs/www.conf /etc/php/7.0/fpm/pool.d/www.conf

COPY ./configs/package.json /root/package.json
RUN cd /root && \
    npm install -q

COPY ./configs/Gemfile /root/Gemfile
RUN cd /root && \
    bundle install

EXPOSE 9000

COPY ./configs/run.sh /scripts/run.sh
RUN chmod -R 755 /scripts

CMD ["/scripts/run.sh", "php-fpm7.0"]
