#!/usr/bin/env bash

pushd $(dirname $0) > /dev/null

./serverState.sh > /dev/null;
STATE=$?

if [[ $STATE -eq 0 ]]; then
    echo "The webserver does not exist!"
    popd > /dev/null
    exit 1
fi

if [[ $STATE -eq 3 ]]; then
    echo "The webserver is already running."
    exit 2
fi

case $STATE in
    1) echo "Cold booting server. If you haven't started the server before, this may take around 10 minutes." ;;
    2) echo "Resuming server." ;;
    4) echo "The server is in an unknown state; kill it with './kill.sh'."; popd > /dev/null; exit 2 ;;
esac

cd devilbox

if [[ $STATE -eq 1 ]]; then
    docker-compose up --no-start httpd mysql php bind
fi

docker-compose start httpd mysql php bind
echo "The webserver has started. It may take a few seconds to begin working."
popd > /dev/null