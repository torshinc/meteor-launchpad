#!/bin/bash

set -e

# Source the configuration file if it exists
if [ -f $APP_SOURCE_DIR/launchpad.conf ]; then
  source <(grep -E "NODE_VERSION|NODE_INSTALL_URL" $APP_SOURCE_DIR/launchpad.conf)
fi

printf "\n[-] Installing Node ${NODE_VERSION}...\n\n"

NODE_DIST=node-v${NODE_VERSION}-linux-x64

# Define default Node.js URL
DEFAULT_NODE_URL="https://nodejs.org/dist/v${NODE_VERSION}/${NODE_DIST}.tar.gz"

# Use NODE_INSTALL_URL if it is set, otherwise use the default URL
NODE_URL="${NODE_INSTALL_URL:-$DEFAULT_NODE_URL}"

cd /tmp
# Downloading Node.js
curl -v -O -L ${NODE_URL}
tar xvzf ${NODE_DIST}.tar.gz
rm ${NODE_DIST}.tar.gz
rm -rf /opt/nodejs
mv ${NODE_DIST} /opt/nodejs

# Creating symbolic links
ln -sf /opt/nodejs/bin/node /usr/bin/node
ln -sf /opt/nodejs/bin/npm /usr/bin/npm
