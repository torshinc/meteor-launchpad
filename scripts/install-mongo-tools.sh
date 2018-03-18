#!/bin/bash

set -e

if [ -f $APP_SOURCE_DIR/launchpad.conf ]; then
  source <(grep INSTALL_MONGO_TOOLS $APP_SOURCE_DIR/launchpad.conf)
fi

if [ "$INSTALL_MONGO_TOOLS" = true ]; then
  printf "\n[-] Installing MongoDB TOOLS ${MONGO_VERSION}...\n\n"

	apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 0C49F3730359A14518585931BC711F9BA15703C6

  echo "deb http://repo.mongodb.org/apt/debian jessie/mongodb-org/$MONGO_MAJOR main" > /etc/apt/sources.list.d/mongodb-org.list

	apt-get update

  apt-get install -y \
    ${MONGO_PACKAGE}-tools=$MONGO_VERSION

fi
