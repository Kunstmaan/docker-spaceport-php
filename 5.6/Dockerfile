FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E5267A6C

RUN echo 'deb http://ppa.launchpad.net/ondrej/php/ubuntu xenial main' >> /etc/apt/sources.list && \
    apt-get -y -q update && \
    apt-get -y -q install apt-utils build-essential curl locales && \
    apt-get -y -q install --no-install-recommends php5.6 php5.6-apcu php5.6-cgi php5.6-cli php5.6-common php5.6-curl php5.6-dev php5.6-fpm php5.6-gd php5.6-imagick php5.6-imap php5.6-intl php5.6-json php5.6-ldap php5.6-mcrypt php5.6-memcached php5.6-mysqlnd php5.6-pgsql php5.6-readline php5.6-sybase php5.6-xmlrpc php5.6-xsl php5.6-mbstring php5.6-soap php5.6-zip php5.6 libapache2-mod-php5.6 && \
    mkdir -p /run/php/ && \
    apt-get -y -q autoremove && \
    apt-get -y -q clean && \
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

COPY ./configs/opcache.ini /etc/php/5.6/mods-available/opcache.ini
RUN phpenmod opcache

COPY ./configs/apcu.ini /etc/php/5.6/mods-available/apcu.ini
RUN phpenmod apcu

COPY ./configs/kunstmaan.ini /etc/php/5.6/mods-available/kunstmaan.ini
RUN phpenmod kunstmaan

COPY ./configs/www.conf /etc/php/5.6/fpm/pool.d/www.conf

EXPOSE 9000

COPY ./configs/run.sh /scripts/run.sh
RUN chmod -R 755 /scripts

CMD ["/scripts/run.sh", "php-fpm5.6"]

WORKDIR /app
