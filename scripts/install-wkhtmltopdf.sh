#!/bin/bash

set -e

############################################
# Wkhtmltopdf
############################################
echo "-----> Install wkhtmltopdffff"

#BUILD_DIR=$1
#CACHE_DIR=$2
#
#DEB="$CACHE_DIR/wkhtmltopdf.deb"
#TS=`date +%s`
#
#WKHTMLTOPDF_DOWNLOAD_URL="https://s3.amazonaws.com/torsh-talent-build-assets/wkhtmltox-0.12.2.1_linux-trusty-amd64.deb"
#echo "-----> Downloading wkhtmltopdf: $WKHTMLTOPDF_DOWNLOAD_URL"
#curl -L --silent -o $DEB $WKHTMLTOPDF_DOWNLOAD_URL
#
#
#echo "-----> Installing wkhtmltopdf 0.12.2.1"
#mkdir -p $BUILD_DIR/.apt
#dpkg -x $DEB $BUILD_DIR/.apt/
#chown -R node:node $BUILD_DIR
#
#echo "Writing profile script"
#mkdir -p $BUILD_DIR/.profile.d
#cat <<EOF >$BUILD_DIR/.profile.d/wkhtmltopdf.sh
#export PATH="\$HOME/.apt/usr/local/bin:\$PATH"
#export LD_LIBRARY_PATH="\$HOME/.apt/usr/local/lib/x86_64-linux-gnu:\$HOME/.apt/usr/local/lib/i386-linux-gnu:\$HOME/.apt/usr/local/lib:\$LD_LIBRARY_PATH"
#export LIBRARY_PATH="\$HOME/.apt/usr/local/lib/x86_64-linux-gnu:\$HOME/.apt/usr/local/lib/i386-linux-gnu:\$HOME/.apt/usr/local/lib:\$LIBRARY_PATH"
#export INCLUDE_PATH="\$HOME/.apt/usr/local/include:\$INCLUDE_PATH"
#export CPATH="\$INCLUDE_PATH"
#export CPPPATH="\$INCLUDE_PATH"
#export PKG_CONFIG_PATH="\$HOME/.apt/usr/local/lib/x86_64-linux-gnu/pkgconfig:\$HOME/.apt/usr/local/lib/i386-linux-gnu/pkgconfig:\$HOME/.apt/usr/local/lib/pkgconfig:\$PKG_CONFIG_PATH"

############################################
# Wkhtmltopdf Dockerfile try 2
############################################

# echo "-----> Install WGET"
# apt-get update
# apt-get install -y wget chrpath libssl-dev libxft-dev

# cd /tmp
# wget https://torsh-talent-build-assets.s3.amazonaws.com/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz
# tar -vxf wkhtmltox-0.12.4_linux-generic-amd64.tar.xz

# chown -R node:node wkhtmltox
# chmod +x wkhtmltox/bin/wkhtmltopdf

# mv wkhtmltox /usr/local/share

# chown -R node:node /usr/local/share/wkhtmltox
# chmod +x /usr/local/share/wkhtmltox/bin/wkhtmltopdf

# ln -sf /usr/local/share/wkhtmltox/bin/wkhtmltopdf /usr/local/bin/wkhtmltopdf
# ln -sf /usr/local/share/wkhtmltox/bin/wkhtmltopdf /usr/bin/wkhtmltopdf

# apt-get -y purge wget

############################################
# Update Wkhtmltopdf to version 0.12.6 from ChatGPT 
############################################

# Install required packages
apt-get update
apt-get install -y wget chrpath libssl-dev libxft-dev

# from https://stackoverflow.com/questions/70073176/docker-install-wkhtmltopdf-error-updating-from-0-12-4-to-0-12-6
apt install -y fontconfig fontconfig-config fonts-dejavu-core libbsd0 \
libfontconfig1 libfontenc1 libfreetype6 libmd0 libpng16-16 \
libx11-6 libx11-data libxau6 libxcb1 libxdmcp6 libxext6 libxrender1 sensible-utils \
ucf x11-common xfonts-75dpi xfonts-base xfonts-encodings xfonts-utils

# Download and install wkhtmltopdf
cd /tmp
wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox_0.12.6-1.bionic_amd64.deb
dpkg -i wkhtmltox_0.12.6-1.bionic_amd64.deb

chown -R node:node /usr/local/bin/wkhtmltopdf
chmod +x /usr/local/bin/wkhtmltopdf
ln -sf /usr/local/bin/wkhtmltopdf /usr/bin/wkhtmltopdf

# Cleanup
rm -f wkhtmltox_0.12.6-1.bionic_amd64.deb
