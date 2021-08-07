#!/usr/bin/env bash
#Configure web server

#set phone repo using environment variable
echo "Cloning from repo "${PHONE_REPO}" and branch "$PHONE_BRANCH

mkdir -p /src
cd /src
git clone $PHONE_REPO
cd e-mission-phone
git clone https://github.com/driftyco/ionic-package-hooks.git ./package-hooks
git fetch origin $PHONE_BRANCH
git checkout -f $PHONE_BRANCH
# Restore the tail command below to debug image creation
# tail -f /dev/null
bash setup/setup_serve.sh
# Normally, this would happen in the setup, but bower doesn't like running as root
# and we are root in the container, of course
# instead of changing that for everybody, we only change it in the container
bower install --allow-root
source setup/activate_serve.sh

echo "About to fix autoreload script"
ORIG="path.join(process.cwd(), 'www/../.')"
NEW="path.join(process.cwd(), 'www/js/**/*'), path.join(process.cwd(), 'www/templates/**/*')"
echo "Replacing $ORIG -> $NEW"
sed -i -e "s|$ORIG|$NEW|g" /src/e-mission-phone/node_modules//connect-phonegap/lib/middleware/autoreload.js
grep "path.join" /src/e-mission-phone/node_modules//connect-phonegap/lib/middleware/autoreload.js
# cp /autoreload.js /src/e-mission-phone/node_modules//connect-phonegap/lib/middleware/
# cp /chokidar-index.js /src/e-mission-phone/node_modules/chokidar/index.js

# launch the webapp
npm run serve
