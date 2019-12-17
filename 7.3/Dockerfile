FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

# Install basics
RUN apt-get update && \
    apt-get install -y apt-transport-https wget unzip git sudo gnupg software-properties-common apt-utils build-essential curl locales vim

# Install php
RUN add-apt-repository ppa:ondrej/php && \
    apt-get -y -q update && \
    apt-get -y -q --allow-unauthenticated install --no-install-recommends libxrender1 php7.3 php7.3-apcu php7.3-bcmath php7.3-cgi php7.3-amqp php7.3-cli php7.3-common php7.3-curl php7.3-dev php7.3-fpm php7.3-gd php7.3-imagick php7.3-imap php7.3-intl php7.3-json php7.3-ldap php7.3-memcached php7.3-mysqlnd php7.3-pgsql php7.3-readline php7.3-sybase php7.3-xmlrpc php7.3-xsl php7.3-mbstring php7.3-soap php-xdebug php7.3-zip libapache2-mod-php7.3 && \
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
COPY ./configs/opcache.ini /etc/php/7.3/mods-available/opcache.ini
COPY ./configs/apcu.ini /etc/php/7.3/mods-available/apcu.ini
COPY ./configs/kunstmaan.ini /etc/php/7.3/mods-available/kunstmaan.ini
COPY ./configs/xdebug.ini /etc/php/7.3/mods-available/xdebug.ini
COPY ./configs/www.conf /etc/php/7.3/fpm/pool.d/www.conf
COPY ./configs/run.sh /scripts/run.sh
RUN phpenmod opcache && \
    phpenmod apcu && \
    phpenmod kunstmaan && \
    phpdismod xdebug && \
    chmod -R 755 /scripts

EXPOSE 9000

CMD ["/scripts/run.sh", "php-fpm7.3 --allow-to-run-as-root"]

WORKDIR /app
