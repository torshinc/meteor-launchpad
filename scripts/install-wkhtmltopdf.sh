#!/bin/bash

############################################
# Wkhtmltopdf
############################################
echo "-----> Install wkhtmltopdf"

BUILD_DIR=$1
CACHE_DIR=$2

DEB="$CACHE_DIR/wkhtmltopdf.deb"
TS=`date +%s`

WKHTMLTOPDF_DOWNLOAD_URL="https://s3.amazonaws.com/torsh-talent-build-assets/wkhtmltox-0.12.2.1_linux-trusty-amd64.deb"
echo "-----> Downloading wkhtmltopdf: $WKHTMLTOPDF_DOWNLOAD_URL"
curl -L --silent -o $DEB $WKHTMLTOPDF_DOWNLOAD_URL


echo "-----> Installing wkhtmltopdf 0.12.2.1"
mkdir -p $BUILD_DIR/.apt
dpkg -x $DEB $BUILD_DIR/.apt/

echo "Writing profile script"
mkdir -p $BUILD_DIR/.profile.d
cat <<EOF >$BUILD_DIR/.profile.d/wkhtmltopdf.sh
export PATH="\$HOME/.apt/usr/local/bin:\$PATH"
export LD_LIBRARY_PATH="\$HOME/.apt/usr/local/lib/x86_64-linux-gnu:\$HOME/.apt/usr/local/lib/i386-linux-gnu:\$HOME/.apt/usr/local/lib:\$LD_LIBRARY_PATH"
export LIBRARY_PATH="\$HOME/.apt/usr/local/lib/x86_64-linux-gnu:\$HOME/.apt/usr/local/lib/i386-linux-gnu:\$HOME/.apt/usr/local/lib:\$LIBRARY_PATH"
export INCLUDE_PATH="\$HOME/.apt/usr/local/include:\$INCLUDE_PATH"
export CPATH="\$INCLUDE_PATH"
export CPPPATH="\$INCLUDE_PATH"
export PKG_CONFIG_PATH="\$HOME/.apt/usr/local/lib/x86_64-linux-gnu/pkgconfig:\$HOME/.apt/usr/local/lib/i386-linux-gnu/pkgconfig:\$HOME/.apt/usr/local/lib/pkgconfig:\$PKG_CONFIG_PATH"