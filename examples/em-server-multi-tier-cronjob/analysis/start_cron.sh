#!/usr/bin/env bash
#Configure web server

#set database URL using environment variable
echo ${DB_HOST}
if [ -z ${DB_HOST} ] ; then
    local_host=`hostname -i`
    sed "s_localhost_${local_host}_" conf/storage/db.conf.sample > conf/storage/db.conf
else
    sed "s_localhost_${DB_HOST}_" conf/storage/db.conf.sample > conf/storage/db.conf
fi
cat conf/storage/db.conf

echo "Setting up conda..."
source setup/setup_conda.sh Linux-x86_64

echo "Setting up the environment..."
source setup/setup.sh

echo "Activating the environment..."
source setup/activate.sh

echo "Installing devcron..."
pip install devcron

# launch the cronjob
echo "Launch the cronjob"
# while true; do sleep 30; done;
devcron ../crontab >> /var/log/cron.console.stdinout 2>&1
