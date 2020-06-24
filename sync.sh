#!/bin/bash

function set_variables() {

    if [ -z ${SYNCTHING_API} ]; then echo "Syncthing api key is unset" && exit 1; fi
    if [ -z ${SYNCTHING_URL} ]; then export SYNCTHING_URL=127.0.0.1; fi
    if [ -z ${SYNCTHING_PORT} ]; then export SYNCTHING_PORT=8384; fi

}

function folder_parse() {

if [ "$1" == "folder" ]; then

    curl -s -X GET -H "X-API-Key: $SYNCTHING_API" http://$SYNCTHING_URL:$SYNCTHING_PORT/rest/system/config | jq ".folders[] | select(.label | contains(\"$NAME\"))" | jq -n "{data: [inputs|{ \"{#FOLDER_ID}\": .id }]}"

fi

}

function device_parse() {

if [ "$1" == "device" ]; then

    DEFAULT_DEVICE_ID=$(curl -s -X GET -H "X-API-Key: $SYNCTHING_API" http://$SYNCTHING_URL:$SYNCTHING_PORT/rest/stats/device | jq "keys | .[length-1]" | sed -es/"^\"\([^\"]*\)\"$"/"\1"/)

    curl -s -X GET -H "X-API-Key: $SYNCTHING_API" http://$SYNCTHING_URL:8384/rest/system/config | jq '.devices[] | select(.deviceID != "'$DEFAULT_DEVICE_ID'")' | jq -n "{data: [inputs|{ \"{#DEVICE_NAME}\": .name , \"{#DEVICE_ID}\": .deviceID }]}"

fi

}

set_variables
folder_parse $1
device_parse $1