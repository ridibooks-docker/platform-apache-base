FROM ridibooks/platform-apache-base:1.0-php73-stretch

# Install required programs
RUN apt-get update && apt-get install -y --no-install-recommends \
    python-pip \
    python-setuptools \
&& docker-php-ext-install \
    pcntl \
&& pip install \
    setuptools \
    pip \
    awscli \
&& pecl install \
    mcrypt-1.0.2 \
&& docker-php-ext-enable \
    mcrypt
