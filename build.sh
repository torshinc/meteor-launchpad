#!/bin/bash

set -e

IMAGE_NAME=${1:-"torshdev/meteor-launchpad"}

printf "\n[-] Building $IMAGE_NAME...\n\n"

docker build -t $IMAGE_NAME:latest .
