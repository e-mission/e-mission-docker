#!/usr/bin/env bash

if [ -d "/conf" ]; then
    echo "Found configuration, overriding..."
    cp -r /conf/* conf/
fi

if [[ -v SIMPLE_INDICES ]]; then
    echo "Replacing database indices for compatibility with DocumentDB"
    sed -i -e "s|HASHED|ASCENDING|" emission/core/get_database.py
    sed -i -e "/GEOSPHERE/d" emission/core/get_database.py
fi

source ./.docker/docker_start_script.sh
