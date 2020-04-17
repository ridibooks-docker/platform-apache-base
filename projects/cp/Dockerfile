FROM ridibooks/platform-apache-base:1.0.2-php73-stretch

# Require for openjdk-8-jre
RUN mkdir -p /usr/share/man/man1

# Install required programs
RUN apt-get update --fix-missing && apt-get install -y --no-install-recommends \
    build-essential \
    gifsicle \
    gnupg \
    ghostscript \
    imagemagick \
    jpegoptim \
    optipng \
    libicu-dev \
    libmagickwand-dev \
    libpng-dev \
    libxml2-dev \
    openssl \
    poppler-utils \
    sudo \
    locales \
    tmux \
    cron \
    openjdk-8-jre \
    libgmp-dev \
&& docker-php-ext-install \
    gd \
    intl \
    pcntl \
    gmp \
&& pecl install \
    igbinary \
    imagick \
    mcrypt-1.0.2 \
&& docker-php-ext-enable \
    igbinary \
    imagick \
    mcrypt
