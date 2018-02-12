#!/usr/bin/env bash

set -e

docker login -u ${DOCKER_USER} -p ${DOCKER_PASS}
docker push ridibooks/performance-apache-base
