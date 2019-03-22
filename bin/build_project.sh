#!/usr/bin/env bash

set -e

PROJECT=${1}
VERSION=${2}
DOCKER_TAG=${VERSION}-${PROJECT}

function print_usage
{
    echo
    echo "Usage: build_project.sh <PROJECT> <VERSION>"
    echo
    echo "Example:"
    echo "  build_project.sh book-api 1.0"
}

if [[ -z "${VERSION}" ]]
then
    echo "No VERSION specified."
    print_usage
    exit 1
fi
if [[ -z "${PROJECT}" ]]
then
    echo "No PROJECT specified."
    print_usage
    exit 1
fi
if [[ ! -e "projects/${PROJECT}/Dockerfile" ]]
then
    echo "No Proejct Dockerfile."
    exit 1
fi

echo "=> Building start - ${PROJECT}"

docker build --pull \
    -f "projects/${PROJECT}/Dockerfile" \
    -t "platform-apache-base:${DOCKER_TAG}" .
