#!/usr/bin/env bash

pushd $(dirname $0) > /dev/null

if [[ ! -d "devilbox" ]]; then
    echo "The webserver does not exist!"
    popd > /dev/null
    exit
fi

pushd devilbox > /dev/null

WEBSERVER_UP=$(docker-compose top | grep "bind")

if [[ -z $WEBSERVER_UP ]]; then
    echo "The webserver is already down or is still shutting down."
    popd > /dev/null
    popd > /dev/null
    exit
fi

docker-compose stop
docker-compose kill
docker-compose rm -f

echo "The webserver has stopped."

popd > /dev/null
popd > /dev/null