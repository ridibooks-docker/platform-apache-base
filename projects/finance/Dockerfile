FROM ridibooks/platform-apache-base:1.1-php74-buster

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
    mcrypt \
&& docker-php-ext-enable \
    mcrypt
