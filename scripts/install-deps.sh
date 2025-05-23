#!/bin/bash

set -e

printf "\n[-] Installing base OS dependencies...\n\n"

# install base dependencies
# Note: python-is-python3 is used instead of python as Python 2 is deprecated

apt-get update

# ensure we can get an https apt source if redirected
# https://github.com/torshdev/meteor-launchpad/issues/50
apt-get install -y python-is-python3 apt-transport-https ca-certificates

if [ -f $APP_SOURCE_DIR/launchpad.conf ]; then
  source <(grep APT_GET_INSTALL $APP_SOURCE_DIR/launchpad.conf)

  if [ "$APT_GET_INSTALL" ]; then
    printf "\n[-] Installing custom apt dependencies...\n\n"
    apt-get install -y $APT_GET_INSTALL
  fi
fi

apt-get install -y --no-install-recommends curl bzip2 libarchive-tools build-essential python-is-python3 git wget


# install gosu

dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')"

wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch"
wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc"

export GNUPGHOME="$(mktemp -d)"

# gpg --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
# ( gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
#  || gpg --keyserver pgp.mit.edu --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
#  || gpg --keyserver keyserver.pgp.com --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 )

for server in ha.pool.sks-keyservers.net \
              hkp://p80.pool.sks-keyservers.net:80 \
              keyserver.ubuntu.com \
              hkp://keyserver.ubuntu.com:80 \
              pgp.mit.edu; do
    gpg --keyserver "$server" --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 && break || echo "Trying new server..."
done

gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu || echo "verification of gosu.asc failed..."

rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc || echo "Rm rf of gosu.asc failed..."

chmod +x /usr/local/bin/gosu

gosu nobody true

apt-get purge -y --auto-remove wget
