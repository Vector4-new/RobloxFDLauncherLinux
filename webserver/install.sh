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

HAS_DOCKER=$(id | grep "docker")

if [[ -z "$HAS_DOCKER" ]]; then
    echo "You are not in the docker group. Add yourself by running (on a superuser account):"
    echo "useradd -g docker $USER"

    popd > /dev/null
    exit
fi

echo "Install the webserver? This requires you to have git (to download the server),"
echo "docker, docker-compose (to start/stop the server), selinux-utils (for getenforce),"
echo "and curl (to probe the server) installed."
echo ""

echo "Note that this may take up to 10 minutes the first time to get the webserver up and running."

while read -p "[Y(es)/N(o)] " -r option
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

git clone https://github.com/cytopia/devilbox

echo ""
echo "Set up passwords for the devilbox UI (disabled by default), the httpd supervisor and the mySQL root account?"
echo "Selecting no will generate a 32-character random password."

while read -p "[Y(es)/N(o)] " -r option
do
    if [[ ${option,,} == "y" ]] || [[ ${option,,} == "yes" ]]; then
        echo "Passwords are being inputted, you just can't see them."
        echo "Do not put equals signs or hashtag signs in the password, they will either corrupt the .env file, or break your password!"
        echo ""

        read -p "Devilbox UI password: " -r -s DEVILBOX_UI_PASS && echo ""
        read -p "HTTPD supervisor password: " -r -s HTTPD_SUPERVISOR_PASS && echo ""
        read -p "MySQL root password: " -r -s MYSQL_ROOT_PASS && echo ""

        break
    elif [[ ${option,,} == "n" ]] || [[ ${option,,} == "no" ]]; then
        DEVILBOX_UI_PASS=$(cat /dev/urandom | tr -dc "a-zA-Z0-9" | head -c 32)
        HTTPD_SUPERVISOR_PASS=$(cat /dev/urandom | tr -dc "a-zA-Z0-9" | head -c 32)
        MYSQL_ROOT_PASS=$(cat /dev/urandom | tr -dc "a-zA-Z0-9" | head -c 32)

        break
    fi
done

echo ""
echo "NOTE: if you want to change the passwords, or forgot them, you can go into devilbox/.env and search for DEVILBOX_UI_PASSWORD, DEVILBOX_HTTPD_MGMT_PASS, and MYSQL_ROOT_PASSWORD."

# escape strings for sed to replace env vars
DEVILBOX_UI_PASS=$(printf '%s\n' "$DEVILBOX_UI_PASS" | sed -e 's/[\/&]/\\&/g')
HTTPD_SUPERVISOR_PASS=$(printf '%s\n' "$HTTPD_SUPERVISOR_PASS" | sed -e 's/[\/&]/\\&/g')
MYSQL_ROOT_PASS=$(printf '%s\n' "$MYSQL_ROOT_PASS" | sed -e 's/[\/&]/\\&/g')

# we have to do it this way because otherwise the file will just be blank (I assume due to trying to read and write to it at the same time)
sed "s/%USERID%/$(id -u)/g" .env.bak > .env
sed "s/%GROUPID%/$(id -g)/g" .env > .env2
sed "s/%DEVILBOXUIPASS%/$DEVILBOX_UI_PASS/g" .env2 > .env3
sed "s/%SUPERVISORDPASS%/$HTTPD_SUPERVISOR_PASS/g" .env3 > .env4
sed "s/%MYSQLROOTPASS%/$MYSQL_ROOT_PASS/g" .env4 > .env5

SELINUX_STATUS=$(getenforce)

if [[ SELINUX_STATS -eq "Enforcing" ]]; then
    sed "s/%MOUNTOPTS%/,z/g" .env5 > .env
else
    sed "s/%MOUNTOPTS%//g" .env5 > .env
fi

rm .env2 .env3 .env4 .env5

cp .env .env.new
mv .env devilbox/.env

echo "Do you want to start up the webserver for the first time to download all necessary binaries?"
echo "This may take some time."

while read -p "[Y(es)/N(o)] " -r option
do
    if [[ ${option,,} == "y" ]] || [[ ${option,,} == "yes" ]]; then
        pushd devilbox > /dev/null

        echo "Starting webserver..."
        docker-compose up httpd mysql php bind &

        # wait until the server is up
        while [[ "$(curl -sf localhost)" != "$(cat ../htdocs/index.php)" ]]; do
            sleep 1
        done

        echo "Everything is done. Stopping webserver..."

        docker-compose stop
        docker-compose kill
        docker-compose rm -f

        echo "Done!"

        popd > /dev/null
        break
    elif [[ ${option,,} == "n" ]] || [[ ${option,,} == "no" ]]; then
        break
    fi
done

popd > /dev/null