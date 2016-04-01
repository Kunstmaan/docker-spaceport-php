FROM ubuntu:trusty

ENV DEBIAN_FRONTEND noninteractive

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E5267A6C

RUN echo 'deb http://ppa.launchpad.net/ondrej/php5/ubuntu trusty main' >> /etc/apt/sources.list && \
    apt-get -y -qq update && \
    apt-get -y -qq install git unzip php5-fpm php5-cli php-pear curl php5-curl php5-intl php5-imagick php5-mysqlnd php5-imap php5-gd php5-json php5-xmlrpc php5-xsl php5-mcrypt php5-apcu php5-memcached && \
    curl -sL https://deb.nodesource.com/setup_4.x | bash - && \
    apt-get -y -qq install build-essential nodejs bundler && \
    ln -sf /usr/bin/nodejs /usr/bin/node && \
    npm install -g bower gulp uglify-js uglifycss && \
    mkdir -p /run/php/ && \
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
    locale-gen en_US

COPY ./configs/kunstmaan.ini /etc/php5/mods-available/kunstmaan.ini
RUN php5enmod kunstmaan

COPY ./configs/www.conf /etc/php5/fpm/pool.d/www.conf

COPY ./configs/package.json /root/package.json
RUN cd /root && \
    npm install -q

COPY ./configs/Gemfile /root/Gemfile
RUN cd /root && \
    bundle install

EXPOSE 9000

COPY ./configs/run.sh /scripts/run.sh
RUN chmod -R 755 /scripts

CMD ["/scripts/run.sh", "php5-fpm"]
