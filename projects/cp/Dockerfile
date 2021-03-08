FROM ridibooks/platform-apache-base:1.0-php74-buster

# Require for openjdk-11-jre
RUN mkdir -p /usr/share/man/man1

# Install required programs
RUN apt-get update --fix-missing && apt-get install -y --no-install-recommends \
    build-essential \
    gifsicle \
    gnupg \
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
    openjdk-11-jre \
    libgmp-dev \
&& docker-php-ext-install \
    gd \
    intl \
    pcntl \
    gmp \
&& pecl install \
    igbinary \
    imagick \
    mcrypt \
&& docker-php-ext-enable \
    igbinary \
    imagick \
    mcrypt

RUN cd /tmp \
 && curl -L https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs9533/ghostscript-9.53.3.tar.gz | tar -xz \
 && cd ghostscript-9.53.3 \
 && ./configure \
 && make install \
 && cd .. \
 && rm -rf ghostscript-9.53.3
