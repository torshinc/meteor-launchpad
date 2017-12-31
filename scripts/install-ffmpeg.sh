#!/bin/bash

set -e

printf "\n[-] Installing FFMPEG...\n\n"

############################################
# FFMPEG
############################################

apt-get update
apt-get install -y wget chrpath libssl-dev libxft-dev

cd /tmp
wget https://s3.amazonaws.com/torsh-talent/ffmpeg3.tar.gz
tar -xzf ffmpeg3.tar.gz

chown -R node:node ffmpeg
chmod +x ffmpeg/bin/ffmpeg
chmod +x ffmpeg/bin/ffprobe

mv ffmpeg /usr/local/share

chown -R node:node /usr/local/share/ffmpeg
chmod +x /usr/local/share/ffmpeg/bin/ffmpeg
chmod +x /usr/local/share/ffmpeg/bin/ffprobe

ln -sf /usr/local/share/ffmpeg/bin/ffmpeg /usr/local/share/ffmpeg
ln -sf /usr/local/share/ffmpeg/bin/ffmpeg /usr/local/bin/ffmpeg
ln -sf /usr/local/share/ffmpeg/bin/ffmpeg /usr/bin/ffmpeg

ln -sf /usr/local/share/ffmpeg/bin/ffprobe /usr/local/share/ffprobe
ln -sf /usr/local/share/ffmpeg/bin/ffprobe /usr/local/bin/ffprobe
ln -sf /usr/local/share/ffmpeg/bin/ffprobe /usr/bin/ffprobe

apt-get -y purge wget