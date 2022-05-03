FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive

# Install basics
RUN apt-get update && \
    apt-get install -y apt-transport-https wget unzip git sudo gnupg software-properties-common apt-utils build-essential curl locales vim

# Install php
RUN add-apt-repository ppa:ondrej/php && \
    apt-get -y -q update && \
    apt-get -y -q --allow-unauthenticated install --no-install-recommends libxrender1 php8.1 php8.1-xml php8.1-apcu php8.1-bcmath php8.1-cgi php8.1-amqp php8.1-cli php8.1-common php8.1-curl php8.1-dev php8.1-fpm php8.1-gd php8.1-imagick php8.1-imap php8.1-intl php8.1-ldap php8.1-memcached php8.1-mysqlnd php8.1-pgsql php8.1-readline php8.1-sybase php8.1-xmlrpc php8.1-xsl php8.1-mbstring php8.1-soap php-xdebug php8.1-zip libapache2-mod-php8.1 && \
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
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer && \
    php -r "unlink('composer-setup.php');"

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
COPY ./configs/opcache.ini /etc/php/8.1/mods-available/opcache.ini
COPY ./configs/apcu.ini /etc/php/8.1/mods-available/apcu.ini
COPY ./configs/kunstmaan.ini /etc/php/8.1/mods-available/kunstmaan.ini
COPY ./configs/xdebug.ini /etc/php/8.1/mods-available/xdebug.ini
COPY ./configs/www.conf /etc/php/8.1/fpm/pool.d/www.conf
COPY ./configs/run.sh /scripts/run.sh
RUN phpenmod opcache && \
    phpenmod apcu && \
    phpenmod kunstmaan && \
    phpdismod xdebug && \
    chmod -R 755 /scripts

EXPOSE 9000

CMD ["/scripts/run.sh", "php-fpm8.1 --allow-to-run-as-root"]

WORKDIR /app
