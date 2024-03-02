#!/usr/bin/env bash

pushd $(dirname $0) > /dev/null

if [[ -d "devilbox" ]]; then
    echo "The webserver already exists!"

    popd > /dev/null
    exit
fi

if [[ $UID -eq 0 ]]; then
    echo "Run this as a regular user."

    popd > /dev/null
    exit
fi

if [[ -n "$(id | grep docker)" ]]; then
    :
else
    echo "Run sudo groupadd docker first"
    echo "You are not in the docker group. Add yourself by running (on a superuser account):"
    echo "usermod -aG docker $USER"
    echo ""
    echo "If you already did, try logging out and back in, or restarting the machine."

    popd > /dev/null
    exit
fi

echo "Install the webserver? This requires you to have git (to download the server),"
echo "docker, docker-compose (to start/stop the server) and curl (to probe the server) installed."
echo ""

echo "Note that this may take up to 10 minutes the first time to get the webserver up and running."

while read -p "[Y/N] " -r option
do
    if [[ ${option,,} == "y" ]] || [[ ${option,,} == "yes" ]]; then
        break
    elif [[ ${option,,} == "n" ]] || [[ ${option,,} == "no" ]]; then
        popd > /dev/null
        exit
    fi
done

echo ""
echo "Downloading devilbox..."

# TODO: maybe use a specific version incase updates break stuff?
git clone https://github.com/cytopia/devilbox

DEVILBOX_UI_PASS=$(cat /dev/urandom | tr -dc "a-zA-Z0-9" | head -c 32)
HTTPD_SUPERVISOR_PASS=$(cat /dev/urandom | tr -dc "a-zA-Z0-9" | head -c 32)
MYSQL_ROOT_PASS=$(cat /dev/urandom | tr -dc "a-zA-Z0-9" | head -c 32)

# escape strings for sed to replace env vars
DEVILBOX_UI_PASS=$(printf '%s\n' "$DEVILBOX_UI_PASS" | sed -e 's/[\/&]/\\&/g')
HTTPD_SUPERVISOR_PASS=$(printf '%s\n' "$HTTPD_SUPERVISOR_PASS" | sed -e 's/[\/&]/\\&/g')
MYSQL_ROOT_PASS=$(printf '%s\n' "$MYSQL_ROOT_PASS" | sed -e 's/[\/&]/\\&/g')

# we have to do it this way because otherwise the file will just be blank (I assume due to trying to read and write to it at the same time)
sed "s/%USERID%/$(id -u)/g" storage/.env > .env
sed "s/%GROUPID%/$(id -g)/g" .env > .env2
sed "s/%DEVILBOXUIPASS%/$DEVILBOX_UI_PASS/g" .env2 > .env3
sed "s/%SUPERVISORDPASS%/$HTTPD_SUPERVISOR_PASS/g" .env3 > .env4
sed "s/%MYSQLROOTPASS%/$MYSQL_ROOT_PASS/g" .env4 > .env5

sed "s/%MOUNTOPTS%//g" .env5 > .env

rm .env2 .env3 .env4 .env5

cp .env storage/.env.bak
mv .env devilbox/.env
cp storage/caseinsensitive.conf devilbox/cfg/apache-2.4

echo "Do you want to start up the webserver for the first time to download all necessary binaries?"
echo "This may take some time."

while read -p "[Y/N] " -r option
do
    if [[ ${option,,} == "y" ]] || [[ ${option,,} == "yes" ]]; then
        ./start.sh
        
        break
    elif [[ ${option,,} == "n" ]] || [[ ${option,,} == "no" ]]; then
        break
    fi
done

popd > /dev/null
