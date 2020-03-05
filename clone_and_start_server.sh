#set phone repo using environment variable
echo "Cloning from repo "${SERVER_REPO}" and branch "$SERVER_BRANCH

mkdir -p /src
cd /src
git clone $SERVER_REPO
cd e-mission-server
git clone https://github.com/driftyco/ionic-package-hooks.git ./package-hooks
git fetch origin $SERVER_BRANCH
git checkout -f $SERVER_BRANCH

conda env update --name emission --file setup/environment36.yml
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

source activate emission

# launch the webapp
./e-mission-py.bash emission/net/api/cfc_webapp.py

# use this as the launch script instead if the webapp is crashing
# note that you need to manually start the server in that case
# tail -f /clone_and_start_server.sh
