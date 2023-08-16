#!/usr/bin/env bash

# exit code   message                comment
# 0           server doesn't exist
# 1           dead
# 2           paused                 exit 0
# 3           running
# 4           unknown state          i.e. paused but exit is not 0

pushd $(dirname $0) > /dev/null

if [[ ! -d "devilbox" ]]; then
    echo "server doesn't exist"
    popd > /dev/null
    exit 0
fi

cd devilbox

if STATE=$(docker-compose ps | grep "devilbox_bind") > /dev/null; then
    if echo "$STATE" | grep "Exit 0" > /dev/null; then
        echo "paused"
        popd > /dev/null
        exit 2
    elif echo "$STATE" | grep "Up" > /dev/null; then
        echo "running"
        popd > /dev/null
        exit 3
    fi
else
    echo "dead"
    popd > /dev/null
    exit 1
fi

echo "unknown state"
popd > /dev/null
exit 4