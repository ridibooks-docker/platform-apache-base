ARG BASE_IMAGE
FROM ${BASE_IMAGE}

RUN rm -rfv /var/lib/apt/lists/* \
&& sed -i "s/http:\/\/deb.debian.org/http:\/\/cloudfront.debian.net/" /etc/apt/sources.list \
&& sed -i "s/http:\/\/security.debian.org/http:\/\/cloudfront.debian.net/" /etc/apt/sources.list

# Install common
RUN docker-php-source extract \
&& apt-get update && apt-get install -y --no-install-recommends \
    apache2 \
    iproute2 \
    libmcrypt-dev \
    mysql-client \
    openssh-client \
    git \
    vim \
    zlib1g-dev \
    libpng-dev \
    libicu-dev \
    libzip-dev \
    zip \
    unzip \
&& docker-php-ext-install \
    pdo \
    pdo_mysql \
    zip \
    gd \
    intl \
    shmop \
&& apt-get autoclean -y && apt-get clean -y && rm -rf /var/lib/apt/lists/* \
&& docker-php-source delete \

# Install XDebug php extention
&& pecl config-set preferred_state beta \
&& pecl install -of xdebug \
&& pecl config-set preferred_state stable \
&& rm -rf /tmp/pear \

# Install Composer and Prestissimo
&& curl -sS https://getcomposer.org/installer | php \
&& mv composer.phar /usr/bin/composer \
&& composer global require hirak/prestissimo \
&& rm -rf /root/.composer/cache/*

# Set Timezone
RUN cp /usr/share/zoneinfo/Asia/Seoul /etc/localtime

# Additional PHP ini configurations
COPY ./php/* /usr/local/etc/php/conf.d/

# Additional Apache configurations
COPY ./apache/conf-available/* /etc/apache2/conf-available/

# Define env variables
ENV XDEBUG_ENABLE 0
ENV PHP_TIMEZONE Asia/Seoul
ENV APACHE_DOC_ROOT /var/www/html

# Enable Apache mods and add PHP info page.
RUN a2enmod rewrite ssl
COPY ./index.php /var/www/html/index.php
COPY ./health.php /var/www/html/health.php

# Change entrypoint
COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["apache2-foreground"]
