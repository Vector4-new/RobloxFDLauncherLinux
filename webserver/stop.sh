#!/usr/bin/env bash

pushd $(dirname $0) > /dev/null

./serverState.sh > /dev/null;
STATE=$?

if [[ $STATE -eq 0 ]]; then
    echo "The webserver does not exist!"
    popd > /dev/null
    exit 1
fi

cd devilbox

if [[ $STATE -eq 3 ]]; then
    docker-compose stop bind httpd php mysql
    echo "The webserver has been stopped."
else
    echo -n "The webserver is "

    case $STATE in
        1) echo "already dead." ;;
        2) echo "already stopped." ;;
        4) echo "in an unknown state. Use './kill.sh' instead." ;;
    esac

    popd > /dev/null
    exit 2
fi