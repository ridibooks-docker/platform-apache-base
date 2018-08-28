#!/usr/bin/env bash

set -e

function start()
{
    docker run -d --rm \
        --name apache-test \
        -v $(pwd)/test:/test \
        -e XDEBUG_ENABLE=1 \
        -p 8000:80 \
        platform-apache-base:latest >/dev/null 2>&1
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
