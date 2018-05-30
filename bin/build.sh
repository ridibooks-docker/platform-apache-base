#!/usr/bin/env bash

set -e

if [ -z "${PHP_VERSION}" ]; then
    PHP_VERSION=7.1
fi

BASE_IMAGE="php:${PHP_VERSION}-apache"

echo "=> Building start with args"
echo "BASE_IMAGE=${BASE_IMAGE}"

docker build \
  --build-arg BASE_IMAGE=${BASE_IMAGE} \
  -t ridibooks/platform-apache-base:${PHP_VERSION} .

docker tag ridibooks/platform-apache-base:${PHP_VERSION} ridibooks/platform-apache-base:latest
