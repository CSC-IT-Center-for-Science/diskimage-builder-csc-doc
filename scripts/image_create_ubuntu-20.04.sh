#!/bin/bash --login
UBUNTU_URL="https://cloud-images.ubuntu.com/focal/current/"
DOWNLOAD_URL="$UBUNTU_URL/focal-server-cloudimg-amd64.img"
IMAGE_NAME="Ubuntu-20.04"
OS_DISTRO_PROPERTY="ubuntu"
IMAGE_VISIBILITY="public"

source $(dirname $0)/image_dl_test_deploy.sh "$DOWNLOAD_URL"
