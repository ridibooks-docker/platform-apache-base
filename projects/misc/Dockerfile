FROM ridibooks/platform-apache-base:1.1.1-php72-stretch

# Install required programs
RUN apt-get update && apt-get install --no-install-recommends -y \
    jpegoptim \
    libjpeg62-turbo-dev \
    libpng-dev \
    optipng \
    cron \
&& docker-php-ext-configure gd \
    --with-gd \
    --with-png-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/ \
&& docker-php-ext-install -j$(nproc) gd \
&& apt-get autoclean -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*
