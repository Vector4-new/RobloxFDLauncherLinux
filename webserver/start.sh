#!/usr/bin/env bash

pushd $(dirname $0) > /dev/null

if [[ ! -d "devilbox" ]]; then
    echo "The webserver does not exist!"
    popd > /dev/null
    exit
fi

pushd devilbox > /dev/null

WEBSERVER_UP=$(docker-compose top | grep "bind")

if [[ ! -z $WEBSERVER_UP ]]; then
    echo "The webserver is already up or is still starting."
    popd > /dev/null
    popd > /dev/null
    exit
fi

echo "Starting webserver. This may take up to a minute, or longer if you haven't started the server before."
nohup docker-compose up httpd mysql php bind >& /dev/null &

# wait until the server is up
while [[ "$(curl -sf localhost)" != "$(cat ../www/robloxfd/htdocs/index.php)" ]]; do
    sleep 1
done

echo "The webserver has started."

popd > /dev/null
popd > /dev/null