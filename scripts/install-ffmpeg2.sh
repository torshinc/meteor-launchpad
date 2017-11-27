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

sudo chown -R 777 ffmpeg
sudo chmod +x ffmpeg/bin/ffmpeg

mv ffmpeg /usr/local/share

sudo chown -R 777 /usr/local/share/ffmpeg
sudo chmod +x /usr/local/share/ffmpeg/bin/ffmpeg

ln -sf /usr/local/share/ffmpeg/bin/ffmpeg /usr/local/share/ffmpeg
ln -sf /usr/local/share/ffmpeg/bin/ffmpeg /usr/local/bin/ffmpeg
ln -sf /usr/local/share/ffmpeg/bin/ffmpeg /usr/bin/ffmpeg

apt-get -y purge wget