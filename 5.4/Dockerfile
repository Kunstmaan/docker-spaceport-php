FROM ubuntu:precise

ENV DEBIAN_FRONTEND noninteractive

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E5267A6C

RUN echo 'deb http://ppa.launchpad.net/ondrej/php5-oldstable/ubuntu precise main' >> /etc/apt/sources.list && \
    apt-get -y -q update && \
    apt-get -y -q install git unzip php5-fpm php5-cli php-pear curl php5-curl php5-intl php5-imagick php5-mysqlnd php5-imap php5-gd php5-json php5-xmlrpc php5-xsl php5-mcrypt php-apc && \
    mkdir -p /run/php/ && \
    curl -sL https://deb.nodesource.com/setup_4.x | bash - && \
    apt-get install -y build-essential nodejs ruby-bundler && \
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

ADD kunstmaan.ini /etc/php5/mods-available/kunstmaan.ini
RUN php5enmod kunstmaan

ADD www.conf /etc/php5/fpm/pool.d/www.conf

COPY package.json /root/package.json

RUN cd /root && \
    npm install -q

EXPOSE 9000

ADD run.sh /scripts/run.sh
RUN chmod -R 755 /scripts

CMD ["/scripts/run.sh"]
