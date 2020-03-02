#!/usr/bin/env bash
#Configure web server

#set database URL using environment variable
echo "Cloning from repo "${PHONE_REPO}

mkdir -p /src
cd /src
git clone $PHONE_REPO
cd e-mission-phone
git clone https://github.com/driftyco/ionic-package-hooks.git ./package-hooks
node ./bin/configure_xml_and_json.js serve

echo "About to install node modules"
npm install

echo "About to install bower modules"
bower install --allow-root
# chmod a+x hooks/before_prepare/download_translation.js
# npm run sass-build

echo "About to fix autoreload script"
ORIG="path.join(process.cwd(), 'www/../.')"
NEW="path.join(process.cwd(), 'www/js/**/*'), path.join(process.cwd(), 'www/templates/**/*')"
echo "Replacing $ORIG -> $NEW"
sed -i -e 's/$ORIG/$NEW/g' /src/e-mission-phone/node_modules//connect-phonegap/lib/middleware/autoreload.js
# cp /autoreload.js /src/e-mission-phone/node_modules//connect-phonegap/lib/middleware/
# cp /chokidar-index.js /src/e-mission-phone/node_modules/chokidar/index.js

# launch the webapp
npm run setup-serve
npm run serve
