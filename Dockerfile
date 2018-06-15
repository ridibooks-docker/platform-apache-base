ARG BASE_IMAGE=php:7.1-apache
FROM ${BASE_IMAGE}
MAINTAINER Kang Ki Tae <kt.kang@ridi.com>

# Install common
RUN docker-php-source extract \
&& apt-get update \
&& apt-get install -y --no-install-recommends \
  wget gnupg software-properties-common vim openssh-client git mysql-client zlib1g-dev libmcrypt-dev libldap2-dev \
&& docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu \
&& docker-php-ext-install ldap pdo zip pdo_mysql \

# Install xdebug php extention
&& pecl config-set preferred_state beta \
&& pecl install -o -f xdebug \
&& rm -rf /tmp/pear \
&& pecl config-set preferred_state stable \

# Install node
&& curl -sL https://deb.nodesource.com/setup_8.x | bash - \
&& apt-get install nodejs -y \

# Install bower
&& npm install -g bower \

# Install composer
&& curl -sS https://getcomposer.org/installer | php \
&& mv composer.phar /usr/bin/composer \

# Clean package files
&& apt-get autoclean -y && apt-get clean -y && rm -rf /var/lib/apt/lists/* \
&& docker-php-source delete

# Additional php ini configurations
ADD ./php/*.ini* /usr/local/etc/php/conf.d/

# Define env variables
ENV XDEBUG_ENABLE 0
ENV PHP_TIMEZONE Asia/Seoul
ENV APACHE_DOC_ROOT /var/www/html

# Enable apache mod and add php info page.
RUN a2enmod rewrite ssl
ADD ./index.php /var/www/html/index.php
ADD ./health.php /var/www/html/health.php

# Change entrypoint
ADD ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["apache2-foreground"]
