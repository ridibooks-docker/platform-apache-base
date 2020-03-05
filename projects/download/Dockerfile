FROM ridibooks/platform-apache-base:1.0-php73-stretch

# Require for openjdk-8-jre
RUN mkdir -p /usr/share/man/man1

# Install required programs
RUN apt-get update && apt-get install -y --no-install-recommends \
    cron \
    openjdk-8-jre \
    zip \
    imagemagick \
    libmagickwand-dev \
    openssl \
    libgmp-dev \
&& docker-php-ext-install \
    gmp \
&& pecl install \
    imagick \
&& docker-php-ext-enable \
    imagick \
&& apt-get autoclean -y && apt-get clean -y && rm -rf /var/lib/apt/lists/* \
&& docker-php-source delete \
&& mkdir -m 777 -p /tmp/user_data \
&& mkdir -m 777 /mnt/s3_cache \
&& mkdir -m 777 /mnt/s3_cache/lock
