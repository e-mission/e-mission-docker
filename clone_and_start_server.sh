#set phone repo using environment variable
echo "Cloning from repo "${SERVER_REPO}" and branch "$SERVER_BRANCH

mkdir -p /src
cd /src
git clone $SERVER_REPO
echo "Finished cloning from repo "${SERVER_REPO}" and branch "$SERVER_BRANCH
cd e-mission-server
git fetch origin $SERVER_BRANCH
git checkout -f $SERVER_BRANCH

echo "About to start conda update, this may take some time..."
source /opt/conda/etc/profile.d/conda.sh
source setup/setup.sh
conda clean -t
conda clean -p

pushd webapp
bower update --allow-root
popd

echo ${DB_HOST}
if [ -z ${DB_HOST} ] ; then
    local_host=`hostname -i`
    sed "s_localhost_${local_host}_" conf/storage/db.conf.sample > conf/storage/db.conf
else
    sed "s_localhost_${DB_HOST}_" conf/storage/db.conf.sample > conf/storage/db.conf
fi
cat conf/storage/db.conf

#set Web Server host using environment variable
echo ${WEB_SERVER_HOST}
if [ -z ${WEB_SERVER_HOST}} ] ; then
    local_host=`hostname -i`
    sed "s_localhost_${local_host}_" conf/net/api/webserver.conf.sample > conf/net/api/webserver.conf
else
    sed "s_localhost_${WEB_SERVER_HOST}_" conf/net/api/webserver.conf.sample > conf/net/api/webserver.conf
fi
cat conf/net/api/webserver.conf

if [ -z ${LIVERELOAD_SRC}} ] ; then
    echo "Live reload disabled, "
else
    echo "Enabling bottle live reload"
    ORIG="run.host=server_host"
    NEW="run(reloader=True,host=server_host"
    echo "Replacing $ORIG -> $NEW"
    sed -i -e "s|$ORIG|$NEW|g" /src/e-mission-server/emission/net/api/cfc_webapp.py
fi

source activate emission

# launch the webapp
./e-mission-py.bash emission/net/api/cfc_webapp.py

# use this as the launch script instead if the webapp is crashing
# note that you need to manually start the server in that case
# tail -f /clone_and_start_server.sh
