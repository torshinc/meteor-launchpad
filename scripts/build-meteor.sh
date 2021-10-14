#!/bin/bash

#
# builds a production meteor bundle directory
#
set -e

# set up npm auth token if one is provided
if [[ "$NPM_TOKEN" ]]; then
  echo "//registry.npmjs.org/:_authToken=$NPM_TOKEN" >> ~/.npmrc
fi

# Fix permissions warning in Meteor >=1.4.2.1 without breaking
# earlier versions of Meteor with --unsafe-perm or --allow-superuser
# https://github.com/meteor/meteor/issues/7959
export METEOR_ALLOW_SUPERUSER=true

# Temporary fix for older version of Node that doesn't recognize new certificate format used by letsEncrypt
# Remove ASAP
# https://docs.meteor.com/expired-certificate.html
printf "\n[-] Exporting Environment variable reject unauth 0\n\n"
export NODE_TLS_REJECT_UNAUTHORIZE=0

printf "\n[-] Release info?\n\n"
cat /etc/os-release

cd $APP_SOURCE_DIR

# Install app deps
printf "\n[-] Running npm install in app directory...\n\n"
NODE_TLS_REJECT_UNAUTHORIZED=0 meteor npm install

# build the bundle
printf "\n[-] Building Meteor application... with reject unauth 0\n\n"
mkdir -p $APP_BUNDLE_DIR
NODE_TLS_REJECT_UNAUTHORIZE="0" meteor build --directory $APP_BUNDLE_DIR --server-only

# run npm install in bundle
printf "\n[-] Running npm install in the server bundle... with reject unauth 0\n\n"
cd $APP_BUNDLE_DIR/bundle/programs/server/
NODE_TLS_REJECT_UNAUTHORIZED=0 meteor npm install --production

# put the entrypoint script in WORKDIR
mv $BUILD_SCRIPTS_DIR/entrypoint.sh $APP_BUNDLE_DIR/bundle/entrypoint.sh

# change ownership of the app to the node user
chown -R node:node $APP_BUNDLE_DIR
