#!/bin/bash

function set_variables() {

    if [ -z ${SYNCTHING_API} ]; then echo "Syncthing api key is unset" && exit 1; fi
    if [ -z ${SYNCTHING_URL} ]; then export SYNCTHING_URL=127.0.0.1; fi
    if [ -z ${SYNCTHING_PORT} ]; then export SYNCTHING_PORT=8384; fi

}

function lastsync_time() {

if [ "$2" == "lastsync_time" ]; then

    LAST_SYNC=`curl -s -X GET -H "X-API-Key: $SYNCTHING_API" http://$SYNCTHING_URL:$SYNCTHING_PORT/rest/stats/folder | jq ".\"$1\".lastFile.at" | sed -es/"^\"\([^\"]*\)\"$"/"\1"/`

    if [ -n "$LAST_SYNC" ]; then echo -n $(date -d "$LAST_SYNC" +%s); fi

fi
}

function lastscan_time() {

if [ "$2" == "lastscan_time" ]; then

    LAST_SCAN=`curl -s -X GET -H "X-API-Key: $SYNCTHING_API" http://$SYNCTHING_URL:$SYNCTHING_PORT/rest/stats/folder | jq ".\"$1\".lastScan" | sed -es/"^\"\([^\"]*\)\"$"/"\1"/`

    if [ -n "$LAST_SCAN" ]; then echo -n $(date -d "$LAST_SCAN" +%s); fi

fi

}

function lastsync_file() {

if [ "$2" == "lastsync_file" ]; then

    curl -s -X GET -H "X-API-Key: $SYNCTHING_API" http://$SYNCTHING_URL:$SYNCTHING_PORT/rest/stats/folder | jq ".\"$1\".lastFile.filename" | sed -es/"^\"\([^\"]*\)\"$"/"\1"/

fi

}

function folder_status_errors() {

if [ "$2" == "folder_status_errors" ]; then

    curl -s -X GET -H "X-API-Key: $SYNCTHING_API" http://$SYNCTHING_URL:$SYNCTHING_PORT/rest/db/status?folder=$1 | jq ".errors"

fi
}

function folder_status_globalBytes() {

if [ "$2" == "folder_status_globalBytes" ]; then

    curl -s -X GET -H "X-API-Key: $SYNCTHING_API" http://$SYNCTHING_URL:$SYNCTHING_PORT/rest/db/status?folder=$1 | jq ".globalBytes"

fi
}

function folder_status_globalDeleted() {

if [ "$2" == "folder_status_globalDeleted" ]; then

    curl -s -X GET -H "X-API-Key: $SYNCTHING_API" http://$SYNCTHING_URL:$SYNCTHING_PORT/rest/db/status?folder=$1 | jq ".globalDeleted"

fi
}

function folder_status_globalDirectories() {

if [ "$2" == "folder_status_globalDirectories" ]; then

    curl -s -X GET -H "X-API-Key: $SYNCTHING_API" http://$SYNCTHING_URL:$SYNCTHING_PORT/rest/db/status?folder=$1 | jq ".globalDirectories"

fi
}

function folder_status_globalFiles() {

if [ "$2" == "folder_status_globalFiles" ]; then

    curl -s -X GET -H "X-API-Key: $SYNCTHING_API" http://$SYNCTHING_URL:$SYNCTHING_PORT/rest/db/status?folder=$1 | jq ".globalFiles"

fi
}

function folder_status_globalTotalItems() {

if [ "$2" == "folder_status_globalTotalItems" ]; then

    curl -s -X GET -H "X-API-Key: $SYNCTHING_API" http://$SYNCTHING_URL:$SYNCTHING_PORT/rest/db/status?folder=$1 | jq ".globalTotalItems"

fi
}

function folder_status_localBytes() {

if [ "$2" == "folder_status_localBytes" ]; then

    curl -s -X GET -H "X-API-Key: $SYNCTHING_API" http://$SYNCTHING_URL:$SYNCTHING_PORT/rest/db/status?folder=$1 | jq ".localBytes"

fi
}

function folder_status_localDeleted() {

if [ "$2" == "folder_status_localDeleted" ]; then

    curl -s -X GET -H "X-API-Key: $SYNCTHING_API" http://$SYNCTHING_URL:$SYNCTHING_PORT/rest/db/status?folder=$1 | jq ".localDeleted"

fi
}

function folder_status_localDirectories() {

if [ "$2" == "folder_status_localDirectories" ]; then

    curl -s -X GET -H "X-API-Key: $SYNCTHING_API" http://$SYNCTHING_URL:$SYNCTHING_PORT/rest/db/status?folder=$1 | jq ".localDirectories"

fi
}

function folder_status_localFiles() {

if [ "$2" == "folder_status_localFiles" ]; then

    curl -s -X GET -H "X-API-Key: $SYNCTHING_API" http://$SYNCTHING_URL:$SYNCTHING_PORT/rest/db/status?folder=$1 | jq ".localFiles"

fi
}

function folder_status_localTotalItems() {

if [ "$2" == "folder_status_localTotalItems" ]; then

    curl -s -X GET -H "X-API-Key: $SYNCTHING_API" http://$SYNCTHING_URL:$SYNCTHING_PORT/rest/db/status?folder=$1 | jq ".localTotalItems"

fi
}

function folder_status_state() {

if [ "$2" == "folder_status_state" ]; then

    curl -s -X GET -H "X-API-Key: $SYNCTHING_API" http://$SYNCTHING_URL:$SYNCTHING_PORT/rest/db/status?folder=$1 | jq ".state" | sed -es/"^\"\([^\"]*\)\"$"/"\1"/

fi
}

function folder_status_stateChanged() {

if [ "$2" == "folder_status_stateChanged" ]; then

    LAST_STATE=`curl -s -X GET -H "X-API-Key: $SYNCTHING_API" http://$SYNCTHING_URL:$SYNCTHING_PORT/rest/db/status?folder=$1 | jq ".stateChanged" | sed -es/"^\"\([^\"]*\)\"$"/"\1"/`

    if [ -n "$LAST_STATE" ]; then echo -n $(date -d "$LAST_STATE" +%s); fi

fi
}

function folder_status_version() {

if [ "$2" == "folder_status_version" ]; then

    curl -s -X GET -H "X-API-Key: $SYNCTHING_API" http://$SYNCTHING_URL:$SYNCTHING_PORT/rest/db/status?folder=$1 | jq ".version"

fi
}

function device_last_seen() {
if [ "$2" == "device_last_seen" ]; then

    LAST_SEEN=`curl -s -X GET -H "X-API-Key: $SYNCTHING_API" http://$SYNCTHING_URL:$SYNCTHING_PORT/rest/stats/device | jq ".\"$1\".lastSeen" | sed -es/"^\"\([^\"]*\)\"$"/"\1"/`

    if [ -n "$LAST_SEEN" ]; then echo -n $(date -d "$LAST_SEEN" +%s); fi

fi
}

set_variables
lastsync_time $1 $2
lastscan_time $1 $2
lastsync_file $1 $2
folder_status_errors $1 $2
folder_status_globalBytes $1 $2
folder_status_globalDeleted $1 $2
folder_status_globalDirectories $1 $2
folder_status_globalFiles $1 $2
folder_status_globalTotalItems $1 $2
folder_status_localBytes $1 $2
folder_status_localDeleted $1 $2
folder_status_localDirectories $1 $2
folder_status_localFiles $1 $2
folder_status_localTotalItems $1 $2
folder_status_state $1 $2
folder_status_stateChanged $1 $2
folder_status_version $1 $2
device_last_seen $1 $2