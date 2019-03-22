#!/usr/bin/env bash

set -e

DOCKER_TAG=${1}

function print_usage
{
    echo
    echo "Usage: test.sh <DOCKER_TAG>"
    echo
    echo "Example:"
    echo "  test.sh 1.0-book-api"
    echo "  test.sh 1.0-php72-stretch"
}

function start()
{
    docker run -d --rm \
        --name apache-test \
        -v $(pwd)/test:/test \
        -e XDEBUG_ENABLE=1 \
        -p 8000:80 \
        "platform-apache-base:${DOCKER_TAG}" >/dev/null 2>&1
}

function stop()
{
    docker stop apache-test >/dev/null 2>&1
}

function test_installed()
{
    docker exec -t apache-test bash -c "php /test/PHPTest.php && composer --version >/dev/null 2>&1"
}

function test_web()
{
    curl -sS localhost:8000/health.php | grep -Eq '^localhost$'
}

if [[ -z "${DOCKER_TAG}" ]]
then
    echo "No DOCKER_TAG specified."
    print_usage
    exit 1
fi

start

if ! test_installed
then
    echo "Failed..(1)"
    RESULT=1

elif ! test_web
then
    echo "Failed..(2)"
    RESULT=1

else
    echo "Success!"
fi

stop
exit ${RESULT:-0}
