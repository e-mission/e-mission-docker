#!/usr/bin/env bash

source ./.docker/setup_config.sh

if [[ -v SIMPLE_INDICES ]]; then
    echo "Replacing database indices for compatibility with DocumentDB"
    sed -i -e "s|HASHED|ASCENDING|" emission/core/get_database.py
    sed -i -e "/GEOSPHERE/d" emission/core/get_database.py
fi

source ./.docker/docker_start_script.sh
