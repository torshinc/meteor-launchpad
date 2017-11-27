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