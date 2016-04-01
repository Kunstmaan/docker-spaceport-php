FROM ubuntu:trusty

ENV DEBIAN_FRONTEND noninteractive

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E5267A6C

RUN echo 'deb http://ppa.launchpad.net/ondrej/php/ubuntu trusty main' >> /etc/apt/sources.list && \
    apt-get -y -q update && \
    apt-get -y -q install git unzip php5.6-fpm php5.6-cli php-pear curl php5.6-curl php5.6-intl php-imagick php5.6-mysqlnd php5.6-imap php5.6-gd php5.6-json php5.6-xmlrpc php5.6-xml php5.6-mcrypt php5.6-mbstring php-apcu php-memcached && \
    echo '' > /etc/php/5.6/mods-available/apcu_bc.ini && \
    mkdir -p /run/php/ && \
    apt-get install -y build-essential nodejs bundler npm && \
    ln -sf /usr/bin/nodejs /usr/bin/node && \
    npm install -g bower gulp uglify-js uglifycss && \
    apt-get -y -q autoremove && \
    apt-get -y -q clean && \
    rm -rf /var/lib/apt/lists/*

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    composer global require hirak/prestissimo

RUN echo Europe/Brussels > /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata

RUN echo 'de_DE ISO-8859-1\n\
de_DE.UTF-8 UTF-8\n\
de_DE@euro ISO-8859-15\n\
en_GB ISO-8859-1\n\
en_GB.ISO-8859-15 ISO-8859-15\n\
en_US ISO-8859-1\n\
en_US.ISO-8859-15 ISO-8859-15\n\
en_US.UTF-8 UTF-8\n\
fr_FR ISO-8859-1\n\
fr_FR.UTF-8 UTF-8\n\
fr_FR@euro ISO-8859-15\n\
nl_BE ISO-8859-1\n\
nl_BE.UTF-8 UTF-8\n\
nl_BE@euro ISO-8859-15\n\
nl_NL ISO-8859-1\n\
nl_NL.UTF-8 UTF-8\n\
nl_NL@euro ISO-8859-15\n'\
>> /etc/locale.gen &&  \
usr/sbin/locale-gen

ADD kunstmaan.ini /etc/php/5.6/mods-available/kunstmaan.ini
RUN phpenmod kunstmaan

ADD www.conf /etc/php/5.6/fpm/pool.d/www.conf

COPY package.json /root/package.json

RUN cd /root && \
    npm install -q

EXPOSE 9000

ADD run.sh /scripts/run.sh
RUN chmod -R 755 /scripts

CMD ["/scripts/run.sh"]
