#!/usr/bin/env bash

set -e

if [ -z "${PHP_VERSION}" ]; then
    PHP_VERSION=7.1
fi

BASE_IMAGE="php:${PHP_VERSION}"

echo "=> Building start with args"
echo "BASE_IMAGE=${BASE_IMAGE}"

docker build \
  --build-arg BASE_IMAGE=${BASE_IMAGE} \
  -t ridibooks/performance-apache-base:${PHP_VERSION} .

docker tag ridibooks/performance-apache-base:${PHP_VERSION} ridibooks/performance-apache-base:latest
