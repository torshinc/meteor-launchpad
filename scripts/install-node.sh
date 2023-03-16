#!/bin/bash

set -e

if [ -f $APP_SOURCE_DIR/launchpad.conf ]; then
  source <(grep NODE_VERSION $APP_SOURCE_DIR/launchpad.conf)
fi

printf "\n[-] Installing Node ${NODE_VERSION}...\n\n"

NODE_DIST=node-v${NODE_VERSION}-linux-x64

apt-get install -y --no-install-recommends curl wget


cd /tmp
wget -v -O -L https://nodejs.org/dist/v${NODE_VERSION}/${NODE_DIST}.tar.xz
tar xvJf ${NODE_DIST}.tar.xz
rm ${NODE_DIST}.tar.xz
rm -rf /opt/nodejs
mv ${NODE_DIST} /opt/nodejs

ln -sf /opt/nodejs/bin/node /usr/bin/node
ln -sf /opt/nodejs/bin/npm /usr/bin/npm

apt-get purge -y --auto-remove wget
