#!/usr/bin/env bash
#Configure web server

#set database URL using environment variable
echo "Cloning from repo "${PHONE_REPO}

cd /src
git clone $PHONE_REPO
cd e-mission-phone
git clone https://github.com/driftyco/ionic-package-hooks.git ./package-hooks
node ./bin/configure_xml_and_json.js serve
npm install
bower install --allow-root
# chmod a+x hooks/before_prepare/download_translation.js
# npm run sass-build

# launch the webapp
npm run setup-serve
npm run serve
