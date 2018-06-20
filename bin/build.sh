#!/usr/bin/env bash

set -e

if [ -z "${PHP_VERSION}" ]; then
    PHP_VERSION=7.1
fi

if [ -z "${DEBIAN_RELEASE}" ]; then
    DEBIAN_RELEASE=stretch
fi

TAG="${PHP_VERSION}-apache-${DEBIAN_RELEASE}"
BASE_IMAGE="php:${TAG}"

echo "=> Building start with args"
echo "BASE_IMAGE=${BASE_IMAGE}"

docker build \
  --build-arg BASE_IMAGE=${BASE_IMAGE} \
  -t ridibooks/platform-apache-base:${PHP_VERSION}-${DEBIAN_RELEASE} .

docker tag ridibooks/platform-apache-base:${PHP_VERSION}-${DEBIAN_RELEASE} ridibooks/platform-apache-base:latest
