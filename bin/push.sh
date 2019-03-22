#!/usr/bin/env bash
set -e

# Variables
DOCKER_REPO_URI=${1}
DOCKER_TAG=${2}
TARGET_IMAGE=platform-apache-base:${DOCKER_TAG}

function print_usage
{
    echo
    echo "Usage: push.sh <DOCKER_REPO_URI> <DOCKER_TAG>"
    echo
    echo "Example:"
    echo "  push.sh ridibooks/platform-apache-base 1.0.2-php72-stretch"
    echo "  push.sh ridibooks/platform-apache-base 1.0-admin"
}

function push
{
    if [[ -n "${DOCKER_USER}" && -n "${DOCKER_PASS}" ]]
    then
        echo "${DOCKER_PASS}" | docker login -u "${DOCKER_USER}" --password-stdin
    else
        docker login
    fi

    echo "Tag ${TARGET_IMAGE} with ${DOCKER_REPO_URI}:${DOCKER_TAG}"
    docker tag "${TARGET_IMAGE}" "${DOCKER_REPO_URI}:${DOCKER_TAG}"

    echo "Push the image to ${DOCKER_REPO_URI}"
    docker push "${DOCKER_REPO_URI}:${DOCKER_TAG}"
}

if [[ -z $(docker images -q "${TARGET_IMAGE}") ]]
then
    echo "TARGET_IMAGE \"${TARGET_IMAGE}\" is wrong. Please check the image existing"
    print_usage
    exit 1
fi

if [[ -z "${DOCKER_REPO_URI}" ]]
then
    echo "No Docker repository specified."
    print_usage
    exit 1
fi

push
