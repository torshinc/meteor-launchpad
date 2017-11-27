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
tar -xzf ffmpeg3.tar.gz
mv ffmpeg /usr/local/share

ln -sf /usr/local/share/ffmpeg/bin/ffmpeg /usr/local/share/ffmpeg
ln -sf /usr/local/share/ffmpeg/bin/ffmpeg /usr/local/bin/ffmpeg
ln -sf /usr/local/share/ffmpeg/bin/ffmpeg /usr/bin/ffmpeg

apt-get -y purge wget