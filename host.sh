#!/usr/bin/env bash

# usage: host.sh <client> <map path> <port>
# other settings like rig type, filtering status, and asset saving can be configured using the 'customize.sh' script.

if [[ $# -ne 3 ]]; then
    echo "usage: $0 <client> <map path> <port>"
    echo "other settings like rig type, filtering status, and asset saving can be configured using the 'customize.sh' script."

    exit
fi

if [[ ! -d "shared" || ! -d "Clients" ]]; then
    echo "Clients don't exist!"
    echo "Install it by going jetray.itch.io, download FilteringDisabled.7z, and extract the 'shared' and 'Clients' folders here"
    popd > /dev/null
    exit
fi

pushd $(dirname $0) > /dev/null


if [[ ! -d "webserver/devilbox" ]]; then
    echo "The webserver is not installed!"
    echo "Install it by going to the webserver directory and running 'install.sh'"
    popd > /dev/null
    exit
fi

curl -sf localhost > /dev/null

if [[ $? -eq 7 ]]; then
    echo "The webserver hasn't been started!"
    echo "Start it by going to the webserver directory and running 'start.sh'"
    popd > /dev/null
    exit
fi

if [[ ! -f $2 ]]; then
    echo "Couldn't find map '$2'"
    popd > /dev/null
    exit
fi

if [ $3 -gt 1023 ] 2> /dev/null; then
    :
else
    echo "Port '$3' is either not an integer over 1023 or an invalid integer"
    popd > /dev/null
    exit
fi

if [[ "$(cat settings/server/assetSaving.txt)" == "true" ]]; then
    cp -R templates/assetsaving/SaveAssets/* webserver/www/robloxfd/htdocs/
else
    cp -R templates/assetsaving/DontSave/* webserver/www/robloxfd/htdocs/
fi

echo $(($RANDOM * 32768 + $RANDOM)) > settings/server/serverPassword.txt

CLIENT=${1^^}
PORT=$3

function Host2022M() {
    # TODO: test
    
    (sed "s/%FILTERINGENABLED%/$(cat settings/server/filteringEnabled.txt)/g" templates/filteringenabled.xml > shared/content/server.rbxmx) &> /dev/null

    cd Clients/2022M
    wine RobloxStudioBeta.exe "" -localPlaceFile "shared/content/place.rbxl" -task StartServer -port $PORT
}

function Host2015L() {
    GAMESERVER=$(cat templates/gameserver.txt)
    GAMESERVER=$(echo "$GAMESERVER" | sed "s/%bodytype%/$(cat settings/server/rigType.txt)/g")
    GAMESERVER=$(echo "$GAMESERVER" | sed "s/%port%/$PORT/g")

    echo "$GAMESERVER" > shared/gameserver.txt

    cd shared
    wine $CLIENT.exe -Console -verbose -placeid:1818 -port $(($RANDOM + 1024))
}

function Host2017M() {
    : # TODO: get soap thingamajig working
}

function Host2021E() {
    : # TODO: get soap thingamajig working
}

function Host2014M() {
    # doesnt work

    cd Clients/2014M
    wine RCCService.exe -a "http://localhost/www.civdefn.tk/" -j "http://localhost/www.civdefn.tk/game/host.php?port=$PORT" -t "1"
}

function Host2008M() {
    : # TODO
}

function Host2018() {
    sed "s/%port%/$PORT/g" templates/gameserver.json > shared/gameserver.json

    cd shared
    wine $CLIENT.exe -Console -verbose -placeid:1818 -localtest "gameserver.json" -port $(($RANDOM + 1024))
}

SERVER_SCRIPT="_G.AdminPasswordPublic='password=$(cat settings/server/serverPassword.txt)' $(sed "s/%bodytype%/$(cat settings/server/rigType.txt)/g" templates/ServerScript.txt)"

(echo $SERVER_SCRIPT > "Clients/$1/Player/content/scripts/CoreScripts/ServerStarterScript.lua") &> /dev/null
(echo $SERVER_SCRIPT > "shared/content/scripts/CoreScripts/ServerStarterScript.lua") &> /dev/null
(echo $SERVER_SCRIPT > "Clients/2021E/RCCService/ExtraContent/scripts/CoreScripts/ServerStarterScript.lua") &> /dev/null

(cat "$2" > webserver/www/robloxfd/htdocs/.127.0.0.1/asset/1818)
(cat "$2" > webserver/www/robloxfd/htdocs/.localhost/asset/1818) &> /dev/null
(cat "$2" > shared/content/place.rbxl) &> /dev/null
(cat "$2" > shared/content/1818) &> /dev/null
(cat "$2" > Clients/2014M/content/temp.rbxl) &> /dev/null

case ${1^^} in
    "2022M") Host2022M ;;
    "2016L"|"2015L") Host2015L ;;
    "2017M") Host2017M ;;
    "2021E") Host2021E ;;
    "2014M") Host2014M ;;
    "2008M") Host2008M ;;
    "2018E"|"2018M"|"2018L") Host2018 ;;
    *) echo "Unrecognized client '$1'."
       popd > /dev/null
       exit
esac

popd > /dev/null