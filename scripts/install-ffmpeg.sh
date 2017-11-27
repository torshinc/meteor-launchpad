#!/bin/bash

############################################
# FFMPEG
############################################
echo "-----> Install ffmpeg"
FFMPEG_BUILD_DIR=$1
FFMPEG_VENDOR_DIR="vendor"
FFMPEG_DOWNLOAD_URL="https://s3.amazonaws.com/torsh-talent/ffmpeg3.tar.gz"

echo "FFMPEG_BUILD_DIR = " $FFMPEG_BUILD_DIR
echo "DOWNLOAD_URL = " $FFMPEG_DOWNLOAD_URL
cd $FFMPEG_BUILD_DIR
mkdir -p $FFMPEG_VENDOR_DIR
cd $FFMPEG_VENDOR_DIR
curl -L --silent $FFMPEG_DOWNLOAD_URL | tar xz

echo "exporting PATH and LIBRARY_PATH"
FFMPEG_PROFILE_PATH="$FFMPEG_BUILD_DIR/.profile.d/ffmpeg.sh"
mkdir -p $(dirname $FFMPEG_PROFILE_PATH)
echo 'export PATH="$PATH:$HOME/vendor/ffmpeg/bin"' >> $FFMPEG_PROFILE_PATH
echo 'export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$HOME/vendor/ffmpeg/lib"' >> $FFMPEG_PROFILE_PATH