FROM ridibooks/platform-apache-base:1.1-php74-buster

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
    libssl-dev \
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
 && mkdir /usr/local/share/ghostscript/9.53.3/Resource \
 && cp -r Resource/Font /usr/local/share/ghostscript/9.53.3/Resource/Font \
 && cd .. \
 && rm -rf ghostscript-9.53.3

RUN cd / \
 && curl -L https://github.com/edenhill/librdkafka/archive/refs/tags/v1.6.1.tar.gz | tar -xz \
 && cd librdkafka-1.6.1 \
 && ./configure --install-deps \
 && make \
 && make install \
 && cd / \
 && pecl install rdkafka-5.0.0 \
 && docker-php-ext-enable rdkafka.so
