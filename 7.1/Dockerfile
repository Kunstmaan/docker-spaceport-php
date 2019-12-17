FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

# Install basics
RUN apt-get update && \
    apt-get install -y apt-transport-https wget unzip git sudo gnupg software-properties-common apt-utils build-essential curl locales vim

# Install php
RUN add-apt-repository ppa:ondrej/php && \
    apt-get -y -q update && \
    apt-get -y -q --allow-unauthenticated install --no-install-recommends libxrender1 php7.1 php7.1-apcu php7.1-bcmath php7.1-cgi php7.1-amqp php7.1-cli php7.1-common php7.1-curl php7.1-dev php7.1-fpm php7.1-gd php7.1-imagick php7.1-imap php7.1-intl php7.1-json php7.1-ldap php7.1-mcrypt php7.1-memcached php7.1-mysqlnd php7.1-pgsql php7.1-readline php7.1-sybase php7.1-xmlrpc php7.1-xsl php7.1-mbstring php7.1-soap php-xdebug php7.1-zip libapache2-mod-php7.1 && \
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
COPY ./configs/opcache.ini /etc/php/7.1/mods-available/opcache.ini
COPY ./configs/apcu.ini /etc/php/7.1/mods-available/apcu.ini
COPY ./configs/kunstmaan.ini /etc/php/7.1/mods-available/kunstmaan.ini
COPY ./configs/xdebug.ini /etc/php/7.1/mods-available/xdebug.ini
COPY ./configs/www.conf /etc/php/7.1/fpm/pool.d/www.conf
COPY ./configs/run.sh /scripts/run.sh
RUN phpenmod opcache && \
    phpenmod apcu && \
    phpenmod kunstmaan && \
    phpdismod xdebug && \
    chmod -R 755 /scripts

EXPOSE 9000

CMD ["/scripts/run.sh", "php-fpm7.1 --allow-to-run-as-root"]

WORKDIR /app
