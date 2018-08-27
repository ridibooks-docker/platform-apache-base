#!/usr/bin/env bash
set -e

# Variables
TARGET_IMAGE=platform-apache-base:latest
DOCKER_REPO_URI=${1}
DOCKER_TAG=${2:-$(git rev-parse --short HEAD)} # default = commit hash
DOCKER_TAG_DEFAULT=latest

function print_usage
{
    echo
    echo "Usage: push.sh <DOCKER_REPO_URI> <DOCKER_TAG>"
    echo
    echo "Example:"
    echo "  push.sh ridibooks/platform-apache-base 1.0.2"
}

function push
{
    echo "${DOCKER_PASS}" | docker login -u "${DOCKER_USER}" --password-stdin

    echo "Tag ${TARGET_IMAGE} with ${DOCKER_REPO_URI}:${DOCKER_TAG_DEFAULT}, ${DOCKER_REPO_URI}:${DOCKER_TAG}"
    docker tag "${TARGET_IMAGE}" "${DOCKER_REPO_URI}:${DOCKER_TAG_DEFAULT}"
    docker tag "${TARGET_IMAGE}" "${DOCKER_REPO_URI}:${DOCKER_TAG}"

    echo "Push the image to ${DOCKER_REPO_URI}"
    docker push "${DOCKER_REPO_URI}:${DOCKER_TAG_DEFAULT}"
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
