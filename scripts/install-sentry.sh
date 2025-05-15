#!/bin/bash

set -e

# Exit if SENTRY_AUTH_TOKEN is not set
if [ -z "$SENTRY_AUTH_TOKEN" ]; then
    echo "SENTRY_AUTH_TOKEN not set, skipping Sentry installation"
    exit 0
fi

# Install Sentry CLI
curl -sL https://sentry.io/get-cli/ | bash

# Get version from version.js file
VERSION=$(sed -nr "s/.*'(.*)'.*/\1/p" $APP_SOURCE_DIR/both/constants/version.js)

# Set Sentry environment variables
export SENTRY_AUTH_TOKEN=$SENTRY_AUTH_TOKEN
export SENTRY_ORG=$SENTRY_ORG
export SENTRY_URL=$SENTRY_URL

# Create Sentry release for client
sentry-cli releases new talent-client@$VERSION
sentry-cli releases files talent-client@$VERSION upload-sourcemaps $APP_BUNDLE_DIR/bundle/programs/web.browser/
sentry-cli releases finalize talent-client@$VERSION

# Create Sentry release for server
sentry-cli releases new talent-server@$VERSION
sentry-cli releases files talent-server@$VERSION upload-sourcemaps $APP_BUNDLE_DIR/bundle/programs/server/
sentry-cli releases finalize talent-server@$VERSION 