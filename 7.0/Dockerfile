FROM ubuntu:wily

ENV DEBIAN_FRONTEND noninteractive

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E5267A6C

RUN echo 'deb http://ppa.launchpad.net/ondrej/php/ubuntu wily main' >> /etc/apt/sources.list && \
    apt-get -y -q update && \
    apt-get -y -q install git unzip php7.0-fpm php7.0-cli php-pear curl php7.0-curl php7.0-intl php-imagick php7.0-mysqlnd php7.0-imap php7.0-gd php7.0-json php7.0-xmlrpc php7.0-xml php7.0-xsl php7.0-mcrypt php-apcu php-memcached && \
    mkdir -p /run/php/ && \
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

ADD kunstmaan.ini /etc/php/7.0/mods-available/kunstmaan.ini
RUN phpenmod kunstmaan

ADD www.conf /etc/php/7.0/fpm/pool.d/www.conf

EXPOSE 9000

ADD run.sh /scripts/run.sh
RUN chmod -R 755 /scripts

CMD ["/scripts/run.sh"]
