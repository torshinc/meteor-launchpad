#!/bin/bash

############################################
# Mediainfo v0.7.91
############################################
#echo "-----> Install mediainfo v0.7.91"
#MEDIAINFO_BUILD_DIR=$1
#MEDIAINFO_VENDOR_DIR="vendor"
#MEDIAINFO_DOWNLOAD_URL="https://s3.amazonaws.com/torsh-talent/mediainfo"

#echo "MEDIAINFO_BUILD_DIR = " $MEDIAINFO_BUILD_DIR
#echo "DOWNLOAD_URL = " $MEDIAINFO_DOWNLOAD_URL
#cd $MEDIAINFO_BUILD_DIR
#echo "after cd"
#mkdir -p $MEDIAINFO_VENDOR_DIR
#cd $MEDIAINFO_VENDOR_DIR
#curl -L --silent $FFMPEG_DOWNLOAD_URL
#chmod +x mediainfo

#echo "exporting PATH and LIBRARY_PATH"
#MEDIAINFO_PROFILE_PATH="$MEDIAINFO_BUILD_DIR/.profile.d/mediainfo.sh"
#mkdir -p $(dirname $MEDIAINFO_PROFILE_PATH)
#echo 'export PATH="$PATH:$HOME/vendor/mediainfo"' >> $MEDIAINFO_PROFILE_PATH