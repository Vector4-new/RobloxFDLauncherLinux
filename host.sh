#!/usr/bin/env bash

# usage: host.sh <client> <map path> <port>
# note: hosting on port 32768 and above has a 1/32768 chance of port collision
# other settings like rig type, filtering status, and asset saving can be configured using the 'customize.sh' script.

if [[ $# -ne 3 ]]; then
    echo "usage: $0 <client> <map path> <port>"
    echo "other settings like rig type, filtering status, and asset saving can be configured using the 'customize.sh' script."

    exit
fi

pushd $(dirname $0) > /dev/null

if [[ ! -d "shared" || ! -d "Clients" ]]; then
    echo "Clients don't exist!"
    echo "Install it by going aeplexi.itch.io/roblox-filtering-disabled, download FilteringDisabled.7z, and extract the 'shared' and 'Clients' folders here"
    popd > /dev/null
    exit
fi

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

# $1 = input
function XMLEscape() {
    ESCAPED="$1"
    ESCAPED="${ESCAPED//&/&amp;}"
    ESCAPED="${ESCAPED//</&gt;}"
    ESCAPED="${ESCAPED//>/&lt;}"
    ESCAPED="${ESCAPED//\'/&apos;}"
    
    echo "${ESCAPED//\"/&quot;}"
}

# this was annoying af to write because there's no good tool to replace strings that have newlines in them

# $1 = ip, $2 = port, $3 = action, $4 = content
function SOAPSend() {
    echo "$(curl --max-time 30 --retry 10 -sf -X POST -H "Accept: text/html" -H "Cache-Control: no-cache" -H "Pragma: no-cache" -H "SOAPAction: $3" --data "$4" "http://$1:$2")"
}

# $1 = baseurl, $2 = content
function SOAPPrepareSend() {
    SOAP_DATA=$(cat templates/SOAP/base.xml)
    SOAP_DATA="${SOAP_DATA//%BASEURL%/$1}"
    echo "${SOAP_DATA//%BASECONTENT%/$2}"
}

# $1 = job, $2 = script
function SOAPCreateOpenJob() {
    OPENJOB=$(cat templates/SOAP/openJob.xml)
    OPENJOB="${OPENJOB//%JOB%/$1}"
    echo "${OPENJOB//%SCRIPT%/$2}"
}

# $1 = name, $2 = script, $3 = arguments
function SOAPFormatScript() {

    SCRIPT=$(cat templates/SOAP/script.xml)
    SCRIPT="${SCRIPT//%SCRIPTNAME%/$(XMLEscape $1)}"
    SCRIPT="${SCRIPT//%SCRIPT%/$2}"
    echo "${SCRIPT//%ARGUMENTS%/Not implemented}"
}

# $1 = jobid, $2 = expirationInSeconds, $3 = category, $4 = cores
function SOAPFormatJob() {
    JOB=$(cat templates/SOAP/job.xml)
    JOB="${JOB//%JOBID%/$(XMLEscape $1)}"
    JOB="${JOB//%EXPIRATIONINSECONDS%/$(XMLEscape $2)}"
    JOB="${JOB//%CATEGORY%/$(XMLEscape $3)}"
    echo "${JOB//%CORES%/$(XMLEscape $4)}"
}

# $1 = jobid, $2 = script
function SOAPFormatExecute() {
    EXECUTE=$(cat templates/SOAP/execute.xml)
    EXECUTE="${EXECUTE//%JOBID%/$(XMLEscape $1)}"
    echo "${EXECUTE//%SCRIPT%/$2}"
}

function Host2022M() {
    # not working
    
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
    wine $CLIENT.exe -Console -verbose -placeid:1818 -port $(($RANDOM + 32768))
}

function Host2017M() {
    SOAP_PORT=$(($RANDOM + 32768))
    GAMESERVER="$(sed "s/%bodytype%/$(cat settings/server/rigType.txt)/g; s/%port%/$PORT/g" templates/2017Mhost.txt)"

    JOB=$(SOAPFormatScript RanScript "$GAMESERVER" "")
    EXECUTE=$(SOAPFormatExecute Test "$JOB")
    CONTENT=$(SOAPPrepareSend roblox.com "$EXECUTE")

    # issue: on slow machines (i.e. VMs) the port will not have opened by the time this sends the script
    # this whole script really needs to be rewritten in python (or similar). shellscript is a good bodge language but is absolutely horrible for anything else
    (sleep 15; SOAPSend localhost $SOAP_PORT Execute "$CONTENT" &> /dev/null) &

    cd shared
    wine 2017M.exe -Console -verbose -placeid:1818 -port $SOAP_PORT
}

function Host2021E() {
    # TODO: seems to host, but need to test
    
    SOAP_PORT=$(($RANDOM + 32768))
    GAMESERVER="$(sed "s/%bodytype%/$(cat settings/server/rigType.txt)/g; s/%port%/$PORT/g" templates/2017Mhost.txt)"

    JOB=$(SOAPFormatScript RanScript "$GAMESERVER" "")
    EXECUTE=$(SOAPFormatExecute Test "$JOB")
    CONTENT=$(SOAPPrepareSend roblox.com "$EXECUTE")

    (sleep 15; SOAPSend localhost $SOAP_PORT Execute "$CONTENT" &> /dev/null) &

    sed "s/%port%/$PORT/g" templates/gameserver.json > shared/gameserver.json

    cd shared
    wine $CLIENT.exe -Console -verbose -placeid:1818 -localtest "gameserver.json" -settingsfile "DevSettingsFile.json" -port $(($RANDOM + 32768))
}

function Host2019M() {
    # TODO: seems to host, but need to test
    
    SOAP_PORT=$(($RANDOM + 32768))
    GAMESERVER="$(sed "s/%bodytype%/$(cat settings/server/rigType.txt)/g; s/%port%/$PORT/g" templates/2017Mhost.txt)"

    JOB=$(SOAPFormatScript RanScript "$GAMESERVER" "")
    EXECUTE=$(SOAPFormatExecute Test "$JOB")
    CONTENT=$(SOAPPrepareSend roblox.com "$EXECUTE")

    (sleep 15; SOAPSend localhost $SOAP_PORT Execute "$CONTENT" &> /dev/null) &

    sed "s/%port%/$PORT/g" templates/gameserver.json > shared/gameserver.json

    cd Clients/$CLIENT
    wine $CLIENT.exe -Console -verbose -placeid:1818 -localtest "gameserver.json" -settingsfile "DevSettingsFile.json" -port $(($RANDOM + 32768))
}

function Host2014M() {
    # doesnt work

    cd Clients/$CLIENT
    wine RCCService.exe -a "http://localhost/www.civdefn.tk/" -j "http://localhost/www.civdefn.tk/game/host.php?port=$PORT" -t "1"
}

function Host2008M() {
    SOAP_PORT=$(($RANDOM + 32768))
    GAMESERVER=$(sed "s/%port%/$PORT/g" templates/2008Mhost.txt)

    JOB=$(SOAPFormatJob Test 600000 0 0)
    SCRIPT=$(SOAPFormatScript GameServer "$GAMESERVER" "")
    CONTENT=$(SOAPPrepareSend localhost/ "$(SOAPCreateOpenJob "$JOB" "$SCRIPT")")

    (sleep 15; SOAPSend localhost $SOAP_PORT OpenJob "$CONTENT" &> /dev/null) &

    cd Clients/2008M/RCCService
    wine RCCService.exe -Console -verbose -placeid:1818 -port $SOAP_PORT
}

function Host2018() {
    sed "s/%port%/$PORT/g" templates/gameserver.json > shared/gameserver.json

    cd shared
    wine $CLIENT.exe -Console -verbose -placeid:1818 -localtest "gameserver.json" -port $(($RANDOM + 32768))
}

SERVER_SCRIPT="_G.AdminPasswordPublic='password=$(cat settings/server/serverPassword.txt)' $(sed "s/%bodytype%/$(cat settings/server/rigType.txt)/g" templates/ServerScript.txt)"

(echo $SERVER_SCRIPT > "Clients/$1/Player/content/scripts/CoreScripts/ServerStarterScript.lua") &> /dev/null
(echo $SERVER_SCRIPT > "shared/content/scripts/CoreScripts/ServerStarterScript.lua") &> /dev/null
(echo $SERVER_SCRIPT > "Clients/2021E/RCCService/ExtraContent/scripts/CoreScripts/ServerStarterScript.lua") &> /dev/null

(cat "$2" > webserver/www/robloxfd/htdocs/.127.0.0.1/asset/1818) &> /dev/null
(cat "$2" > webserver/www/robloxfd/htdocs/.localhost/asset/1818) &> /dev/null
(cat "$2" > shared/content/place.rbxl) &> /dev/null
(cat "$2" > shared/content/1818) &> /dev/null
(cat "$2" > Clients/2014M/content/temp.rbxl) &> /dev/null

case ${1^^} in
    "2022M") Host2022M ;;
    "2016L"|"2015M") Host2015L ;;
    "2017M") Host2017M ;;
    "2021E"|"2020L") Host2021E ;;
    "2019M") Host2019M ;;
    "2014M"|"2013L") Host2014M ;;
    "2008M") Host2008M ;;
    "2018E"|"2018M"|"2018L") Host2018 ;;
    *) echo "Unrecognized client '$1'." ;;
esac

popd > /dev/null
