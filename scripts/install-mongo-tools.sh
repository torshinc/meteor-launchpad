#!/bin/bash

set -e

if [ -f $APP_SOURCE_DIR/launchpad.conf ]; then
  source <(grep INSTALL_MONGO_TOOLS $APP_SOURCE_DIR/launchpad.conf)
fi

if [ "$INSTALL_MONGO_TOOLS" = true ]; then
  printf "\n[-] Installing MongoDB TOOLS ${MONGO_VERSION}...\n\n"

	# apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 0C49F3730359A14518585931BC711F9BA15703C6
	#Keys for mongoDB version 3.4
	for server in ha.pool.sks-keyservers.net \
              hkp://p80.pool.sks-keyservers.net:80 \
              keyserver.ubuntu.com \
              hkp://keyserver.ubuntu.com:80 \
              pgp.mit.edu; do
    apt-key adv --keyserver "$server" --recv-keys 0C49F3730359A14518585931BC711F9BA15703C6 && break || echo "Trying new server..."
  done

  #Keys for mongoDB version 4.2
	for server in ha.pool.sks-keyservers.net \
              hkp://p80.pool.sks-keyservers.net:80 \
              keyserver.ubuntu.com \
              hkp://keyserver.ubuntu.com:80 \
              pgp.mit.edu; do
    apt-key adv --keyserver "$server" --recv-keys 4B7C549A058F8B6B && break || echo "Trying new server..."
  done

  #Keys for mongoDB version 4.4
	for server in ha.pool.sks-keyservers.net \
              hkp://p80.pool.sks-keyservers.net:80 \
              keyserver.ubuntu.com \
              hkp://keyserver.ubuntu.com:80 \
              pgp.mit.edu; do
    apt-key adv --keyserver "$server" --recv-keys 656408E390CFB1F5 && break || echo "Trying new server..."
  done

  # for mongoDB version 3.4
  # echo "deb http://repo.mongodb.org/apt/debian jessie/mongodb-org/$MONGO_MAJOR main" > /etc/apt/sources.list.d/mongodb-org.list

  # for mongoDB version 4.2 from https://itectec.com/ubuntu/ubuntu-apt-get-fails-on-16-04-or-18-04-installing-mongodb/
  echo "deb [arch=amd64] http://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/$MONGO_MAJOR multiverse" > /etc/apt/sources.list.d/mongodb-org-$MONGO_MAJOR.list

  # for mongoDB version 4.4 (on Ubuntu 20.04) from https://itectec.com/ubuntu/ubuntu-apt-get-fails-on-16-04-or-18-04-installing-mongodb/
  # echo "deb [arch=amd64] http://repo.mongodb.org/apt/ubuntu $(lsb_release -sc)/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org.list


	apt-get update

  apt-get install -y \
    ${MONGO_PACKAGE}=$MONGO_VERSION \
    ${MONGO_PACKAGE}-shell=$MONGO_VERSION \
    ${MONGO_PACKAGE}-tools=$MONGO_VERSION

  mkdir -p /data/{db,configdb}
  chown -R mongodb:mongodb /data/{db,configdb}

	rm -rf /var/lib/apt/lists/*
	rm -rf /var/lib/mongodb
  mv /etc/mongod.conf /etc/mongod.conf.orig

fi
