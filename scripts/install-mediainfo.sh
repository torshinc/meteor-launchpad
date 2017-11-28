#!/bin/bash

set -e

printf "\n[-] Installing MEDIA INFO...\n\n"

############################################
# MEDIA INFRO
############################################

apt-get update
apt-get install -y wget chrpath libssl-dev libxft-dev

cd /tmp
wget https://s3.amazonaws.com/torsh-talent-build-assets/mediainfo-0.7.91.tar.gz
tar -xzf mediainfo-0.7.91.tar.gz

chown -R node:node mediainfo
chmod +x mediainfo/mediainfo

mv mediainfo /usr/local/share

chown -R node:node /usr/local/share/mediainfo
chmod +x /usr/local/share/mediainfo/mediainfo

ln -sf /usr/local/share/mediainfo/mediainfo /usr/local/bin/mediainfo
ln -sf /usr/local/share/mediainfo/mediainfo /usr/bin/mediainfo

echo "-----> Exporting PATH and LIBRARY_PATH"
PROFILE_PATH="$BUILD_DIR/.profile.d/mediainfo.sh"
mkdir -p $(dirname $PROFILE_PATH)
echo 'export PATH="$PATH:/usr/local/share/mediainfo"' >> $PROFILE_PATH
echo "-----> MEDIAINFO " $MEDIAINFO_VERSION " COMPLETED"

apt-get -y purge wget