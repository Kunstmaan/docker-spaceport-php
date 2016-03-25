FROM ubuntu:wily

ENV DEBIAN_FRONTEND noninteractive

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E5267A6C

RUN echo 'deb http://ppa.launchpad.net/ondrej/php/ubuntu wily main' >> /etc/apt/sources.list && \
    apt-get -y -q update && \
    apt-get -y -q install php7.0-fpm php-pear php7.0-curl php7.0-intl php-imagick php7.0-mysqlnd php7.0-imap php7.0-gd php7.0-json php7.0-xmlrpc php7.0-xsl php7.0-mcrypt php-apcu && \
    mkdir -p /run/php/ && \
    apt-get -y -q autoremove && \
    apt-get -y -q clean && \
    rm -rf /var/lib/apt/lists/*

ADD kunstmaan.ini /etc/php/7.0/mods-available/kunstmaan.ini
RUN phpenmod kunstmaan

ADD www.conf /etc/php/7.0/fpm/pool.d/www.conf

EXPOSE 9000
CMD ["php-fpm7.0"]
#CMD ["/bin/bash"]
