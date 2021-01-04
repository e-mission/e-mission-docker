source /clone_server.sh

if [[ -v SIMPLE_INDICES ]]; then
    echo "Replacing database indices for compatibility with DocumentDB"
    sed -i -e "s|HASHED|ASCENDING|" emission/core/get_database.py
    sed -i -e "/GEOSPHERE/d" emission/core/get_database.py
fi

#set database URL using environment variable
#in the webapp, this is set in start_script
#but we don't call start_script here since we don't want to start the server
#but we still need to connect to the database
echo ${DB_HOST}
if [ -z ${DB_HOST} ] ; then
    local_host=`hostname -i`
    sed "s_localhost_${local_host}_" conf/storage/db.conf.sample > conf/storage/db.co
nf
else
    sed "s_localhost_${DB_HOST}_" conf/storage/db.conf.sample > conf/storage/db.conf
fi
cat conf/storage/db.conf

echo "Activating the environment..."
source setup/activate.sh

echo "Installing devcron..."
pip install devcron

# launch the cronjob
echo "Launch the cronjob"
# while true; do sleep 30; done;
devcron ../crontab >> /var/log/cron.console.stdinout 2>&1
