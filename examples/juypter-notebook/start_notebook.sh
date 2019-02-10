#!/usr/bin/env bash
#Configure web server

#set database URL using environment variable
echo "DB host = "${DB_HOST}
if [ -z ${DB_HOST} ] ; then
    local_host=`hostname -i`
    sed "s_localhost_${local_host}_" conf/storage/db.conf.sample > conf/storage/db.conf
else
    sed "s_localhost_${DB_HOST}_" conf/storage/db.conf.sample > conf/storage/db.conf
fi

### configure the saved-notebooks directory for persistent notebooks

# Ensure that the database config is available so that we can connect to it
mkdir -p saved-notebooks/conf/storage
cp conf/storage/db.conf saved-notebooks/conf/storage/db.conf
cat conf/storage/db.conf

#set Web Server host using environment variable
echo "Web host = "${WEB_SERVER_HOST}

# change python environment
source activate emission

# launch the webapp
PYTHONPATH=/usr/src/app jupyter notebook --no-browser --ip=${WEB_SERVER_HOST} --allow-root
