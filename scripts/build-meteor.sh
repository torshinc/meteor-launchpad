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


printf "\n[-] Release info?\n\n"
cat /etc/os-release

cd $APP_SOURCE_DIR

# Install app deps
printf "\n[-] Running npm install in app directory...\n\n"
meteor npm install

# Setting node options to prevent issue with heapsize during build
export NODE_OPTIONS="--max-old-space-size=6144"

# build the bundle
printf "\n[-] Building Meteor application...\n\n"
mkdir -p $APP_BUNDLE_DIR
meteor build --directory $APP_BUNDLE_DIR --server-only

# run npm install in bundle
printf "\n[-] Running npm install in the server bundle...\n\n"
cd $APP_BUNDLE_DIR/bundle/programs/server/
meteor npm install --production

printf "\n[-] Fixing Fibers PATH bug in node>8.x...\n\n"
cd $APP_BUNDLE_DIR/bundle/programs/server/
npm remove fibers && npm install fibers@5.0.1

# put the entrypoint script in WORKDIR
mv $BUILD_SCRIPTS_DIR/entrypoint.sh $APP_BUNDLE_DIR/bundle/entrypoint.sh

# change ownership of the app to the node user
chown -R node:node $APP_BUNDLE_DIR
