#!/bin/bash

set -e

printf "\n[-] Installing FFMPEG...\n\n"

############################################
# FFMPEG
############################################

FFMPEG_DOWNLOAD_URL="https://s3.amazonaws.com/torsh-talent/ffmpeg3.tar.gz"

apt-get update
apt-get install -y wget chrpath libssl-dev libxft-dev

cd /tmp
wget $FFMPEG_DOWNLOAD_URL
tar -xvjf ffmpeg3.tar.gz

chown -R 777 ffmpeg
chmod +x ffmpeg/bin/ffmpeg

mv ffmpeg /usr/local/share

chown -R 777 /usr/local/share/ffmpeg
chmod +x /usr/local/share/ffmpeg/bin/ffmpeg

ln -sf /usr/local/share/ffmpeg/bin/ffmpeg /usr/local/share/ffmpeg
ln -sf /usr/local/share/ffmpeg/bin/ffmpeg /usr/local/bin/ffmpeg
ln -sf /usr/local/share/ffmpeg/bin/ffmpeg /usr/bin/ffmpeg

apt-get -y purge wget