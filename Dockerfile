ARG BASE_IMAGE
FROM ${BASE_IMAGE}

# Install common
RUN docker-php-source extract \
&& apt-get update && apt-get install -y --no-install-recommends \
    iproute2 \
    libmcrypt-dev \
    mysql-client \
    openssh-client \
    git \
    gnupg \
    vim \
    zlib1g-dev \
&& docker-php-ext-install \
    pdo \
    pdo_mysql \
    zip \
&& apt-get autoclean -y && apt-get clean -y && rm -rf /var/lib/apt/lists/* \
&& docker-php-source delete \

# Install XDebug php extention
&& pecl install xdebug \
&& rm -rf /tmp/pear \

# Install Node
&& curl -sL https://deb.nodesource.com/setup_10.x | bash - \
&& apt-get install nodejs -y --no-install-recommends \
&& rm -rf /root/.npm/cache/* \

# Install Composer and Prestissimo
&& curl -sS https://getcomposer.org/installer | php \
&& mv composer.phar /usr/bin/composer \
&& composer global require hirak/prestissimo \
&& rm -rf /root/.composer/cache/*

# Additional PHP ini configurations
ADD ./php/*.ini* /usr/local/etc/php/conf.d/

# Define env variables
ENV XDEBUG_ENABLE 0
ENV PHP_TIMEZONE Asia/Seoul
ENV APACHE_DOC_ROOT /var/www/html

# Enable Apache mods and add PHP info page.
RUN a2enmod rewrite ssl
ADD ./index.php /var/www/html/index.php
ADD ./health.php /var/www/html/health.php

# Change entrypoint
ADD ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["apache2-foreground"]
