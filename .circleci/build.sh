#!/bin/bash

set -e

IMAGE_NAME=${DOCKER_IMAGE_NAME:-"torshdev/meteor-launchpad"}

# build the latest
docker build -t $IMAGE_NAME:latest .
