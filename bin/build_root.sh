#!/usr/bin/env bash

set -e

DOCKER_TAG=${1}
PHP_VERSION=${2:-7.2}
DEBIAN_RELEASE=${3:-stretch}
BASE_IMAGE=php:${PHP_VERSION}-apache-${DEBIAN_RELEASE}

function print_usage
{
    echo
    echo "Usage: build_root.sh <DOCKER_TAG> <PHP_VERSION> <DEBIAN_RELEASE>"
    echo
    echo "Example:"
    echo "  build_root.sh 1.0-php72-stretch"
    echo "  build_root.sh 1.0-php73-stretch 7.3"
    echo "  build_root.sh 1.0-php71-jessie 7.1 jessie"
}

if [[ -z "${DOCKER_TAG}" ]]
then
    echo "No DOCKER_TAG specified."
    print_usage
    exit 1
fi

echo "=> Building start with args"
echo "BASE_IMAGE=${BASE_IMAGE}"

echo "Build a image - platform-apache-base:${DOCKER_TAG}"
docker build --pull \
    --build-arg "BASE_IMAGE=${BASE_IMAGE}" \
    -t "platform-apache-base:${DOCKER_TAG}" .
