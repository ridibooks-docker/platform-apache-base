FROM ridibooks/platform-apache-base:1.0-php74-buster

# Require for openjdk-11-jre
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
    python-pip \
    python-setuptools \
    openssl \
    poppler-utils \
    openjdk-11-jre \
    rsync \
    sudo \
    locales \
    tmux \
    cron \
    libgmp-dev \
&& docker-php-ext-install \
    bcmath \
    gd \
    intl \
    shmop \
    pcntl \
    gmp \
&& pecl install \
    igbinary \
    imagick \
    mcrypt \
&& docker-php-ext-enable \
    igbinary \
    imagick \
    mcrypt \
&& pip install \
    setuptools \
    pip \
    awscli

RUN a2enmod proxy proxy_http
