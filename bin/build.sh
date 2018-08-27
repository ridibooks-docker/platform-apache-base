#!/usr/bin/env bash

set -e

DOCKER_TAG=${1}
BASE_IMAGE=php:${PHP_VERSION:-7.1}-apache-${DEBIAN_RELEASE:-stretch}

function print_usage
{
    echo
    echo "Usage: build.sh <DOCKER_TAG>"
    echo
    echo "Example:"
    echo "  build.sh latest"
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
