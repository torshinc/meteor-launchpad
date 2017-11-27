#!/bin/bash

set -e

############################################
# FFMPEG
############################################
echo "-----> Install ffmpeg"
FFMPEG_BUILD_DIR=$1
FFMPEG_VENDOR_DIR="ffmpegvendor"
FFMPEG_DOWNLOAD_URL="https://s3.amazonaws.com/torsh-talent/ffmpeg3.tar.gz"


echo "FFMPEG_BUILD_DIR = " $FFMPEG_BUILD_DIR
echo "DOWNLOAD_URL = " $FFMPEG_DOWNLOAD_URL
mkdir -p $FFMPEG_BUILD_DIR
cd $FFMPEG_BUILD_DIR
mkdir -p $FFMPEG_VENDOR_DIR
cd $FFMPEG_VENDOR_DIR
curl -L --silent $FFMPEG_DOWNLOAD_URL | tar xz

echo "exporting PATH and LIBRARY_PATH"
FFMPEG_PROFILE_PATH="$FFMPEG_BUILD_DIR/.profile.d/ffmpeg.sh"
mkdir -p $(dirname $FFMPEG_PROFILE_PATH)
echo 'export PATH="$PATH:$FFMPEG_BUILD_DIR/$FFMPEG_VENDOR_DIR/ffmpeg/bin"' >> $FFMPEG_PROFILE_PATH
echo 'export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$FFMPEG_BUILD_DIR/$FFMPEG_VENDOR_DIR/ffmpeg/lib"' >> $FFMPEG_PROFILE_PATH

chown -R $(id -u):$(id -g) $FFMPEG_BUILD_DIR
chmod +x $FFMPEG_BUILD_DIR/$FFMPEG_VENDOR_DIR/ffmpeg/bin/ffmpeg

ln -sf $FFMPEG_BUILD_DIR/$FFMPEG_VENDOR_DIR/ffmpeg/bin/ffmpeg /usr/local/share/ffmpeg
ln -sf $FFMPEG_BUILD_DIR/$FFMPEG_VENDOR_DIR/ffmpeg/bin/ffmpeg /usr/local/bin/ffmpeg
ln -sf $FFMPEG_BUILD_DIR/$FFMPEG_VENDOR_DIR/ffmpeg/bin/ffmpeg /usr/bin/ffmpeg