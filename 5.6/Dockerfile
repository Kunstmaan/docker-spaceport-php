FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

# Install basics
RUN apt-get update && \
    apt-get install -y apt-transport-https wget unzip git sudo gnupg software-properties-common apt-utils build-essential curl locales vim

# Install php
RUN add-apt-repository ppa:ondrej/php && \
    apt-get -y -q update && \
    apt-get -y -q --allow-unauthenticated install --no-install-recommends libxrender1 php5.6 php5.6-apcu php5.6-bcmath php5.6-cgi php5.6-amqp php5.6-cli php5.6-common php5.6-curl php5.6-dev php5.6-fpm php5.6-gd php5.6-imagick php5.6-imap php5.6-intl php5.6-json php5.6-ldap php5.6-mcrypt php5.6-memcached php5.6-mysqlnd php5.6-pgsql php5.6-readline php5.6-sybase php5.6-xmlrpc php5.6-xsl php5.6-mbstring php5.6-soap php-xdebug php5.6-zip libapache2-mod-php5.6 && \
    mkdir -p /run/php/

# Install wkhtmltopdf, increased container size by 6 times sadly and clean up some unused packages
RUN mkdir -p /tmp/wkhtml && cd /tmp/wkhtml && \
    wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.bionic_amd64.deb  && \
    apt install -y /tmp/wkhtml/wkhtmltox_0.12.5-1.bionic_amd64.deb && \
    apt-get remove -y software-properties-common apt-utils && \
    apt-get -y -q autoremove && \
    apt-get -y -q clean && \
    rm -rf /var/lib/apt/lists/* && rm -rf /tmp/wkhtml

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    composer global require hirak/prestissimo

# Set timezone and locale
RUN echo Europe/Brussels > /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata && \
    locale-gen nl_BE && \
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

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV COMPOSER_ALLOW_SUPERUSER 1

# fix php config
COPY ./configs/opcache.ini /etc/php/5.6/mods-available/opcache.ini
COPY ./configs/apcu.ini /etc/php/5.6/mods-available/apcu.ini
COPY ./configs/kunstmaan.ini /etc/php/5.6/mods-available/kunstmaan.ini
COPY ./configs/xdebug.ini /etc/php/5.6/mods-available/xdebug.ini
COPY ./configs/www.conf /etc/php/5.6/fpm/pool.d/www.conf
COPY ./configs/run.sh /scripts/run.sh
RUN phpenmod opcache && \
    phpenmod apcu && \
    phpenmod kunstmaan && \
    phpdismod xdebug && \
    chmod -R 755 /scripts

EXPOSE 9000

CMD ["/scripts/run.sh", "php-fpm5.6 --allow-to-run-as-root"]

WORKDIR /app
