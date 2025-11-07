#1/usr/bin/env bash

if [ "$PLP_CONNECT_PATH" == "" ]; then
    echo "please use 'plp connect <PATH>' first"
    exit 1
    fi

env "HOME=$PLP_CONNECT_PATH" plp "${@:1}"