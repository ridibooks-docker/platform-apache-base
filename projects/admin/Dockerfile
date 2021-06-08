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

RUN cd /tmp \
 && curl -L https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs9533/ghostscript-9.53.3.tar.gz | tar -xz \
 && cd ghostscript-9.53.3 \
 && ./configure \
 && make install \
 && mkdir /usr/local/share/ghostscript/9.53.3/Resource \
 && cp -r Resource/Font /usr/local/share/ghostscript/9.53.3/Resource/Font \
 && cd .. \
 && rm -rf ghostscript-9.53.3

RUN a2enmod proxy proxy_http
