FROM ridibooks/platform-apache-base:1.0-php73-stretch

RUN apt-get update \
&& apt-get install -y --no-install-recommends \
    cron \
&& apt-get autoclean -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*
