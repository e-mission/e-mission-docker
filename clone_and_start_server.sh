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
source setup/setup_conda.sh Linux-x86_64
source setup/setup.sh
conda clean -t
conda clean -p

cp /index.html webapp/www/index.html

if [ -z ${LIVERELOAD_SRC}} ] ; then
    echo "Live reload disabled, "
else
    echo "Enabling bottle live reload"
    ORIG="run.host=server_host"
    NEW="run(reloader=True,host=server_host"
    echo "Replacing $ORIG -> $NEW"
    sed -i -e "s|$ORIG|$NEW|g" /src/e-mission-server/emission/net/api/cfc_webapp.py
fi

source /start_script.sh

# use this as the launch script instead if the webapp is crashing
# note that you need to manually start the server in that case
# tail -f /clone_and_start_server.sh
