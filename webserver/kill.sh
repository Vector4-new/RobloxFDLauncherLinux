#!/usr/bin/env bash

pushd $(dirname $0) > /dev/null

./serverState.sh > /dev/null;
STATE=$?

if [[ $STATE -eq 0 ]]; then
    echo "The webserver does not exist!"
    popd > /dev/null
    exit 1
fi

if [[ $STATE -eq 1 ]]; then
    echo "The webserver is already dead."
    popd > /dev/null
    exit 2
fi

cd devilbox

docker-compose stop bind httpd php mysql
docker-compose kill
docker-compose rm -f

echo "The webserver has been killed."
popd > /dev/null