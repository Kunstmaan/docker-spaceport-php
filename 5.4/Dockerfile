FROM ubuntu:precise

ENV DEBIAN_FRONTEND noninteractive

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E5267A6C
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C3173AA6

RUN echo 'deb http://ppa.launchpad.net/ondrej/php5-oldstable/ubuntu precise main' >> /etc/apt/sources.list && \
    apt-get -y -qq update && \
    apt-get -y -qq install git unzip php5-fpm php5-cli php-pear curl php5-curl php5-gmp php5-sqlite php5-intl php5-imagick php5-mysqlnd php5-imap php5-gd php5-json php5-xmlrpc php5-xsl php5-mcrypt php-apc && \
    mkdir -p /run/php/ && \
    curl -sL https://deb.nodesource.com/setup_4.x | bash - && \
    apt-get -y -qq install build-essential nodejs && \
    echo 'deb http://ppa.launchpad.net/brightbox/ruby-ng/ubuntu precise main' >> /etc/apt/sources.list && \
    apt-get -y -qq update && \
    apt-get -y -qq install ruby1.9.1 ruby1.9.1-dev ruby-switch && \
    ruby-switch --set ruby1.9.1 && \
    gem1.9.1 install bundler && \
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

WORKDIR /app
