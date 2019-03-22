FROM ridibooks/platform-apache-base:1.1.1-php72-stretch

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
&& docker-php-ext-install \
    gd \
    intl \
&& pecl install \
    igbinary \
    imagick \
    mcrypt-1.0.2 \
&& docker-php-ext-enable \
    igbinary \
    imagick \
    mcrypt
