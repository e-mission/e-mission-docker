#!/usr/bin/env bash
source /clone_server.sh

if [[ -v SIMPLE_INDICES ]]; then
    echo "Replacing database indices for compatibility with DocumentDB"
    sed -i -e "s|HASHED|ASCENDING|" emission/core/get_database.py
    sed -i -e "/GEOSPHERE/d" emission/core/get_database.py
fi

source /start_script.sh
