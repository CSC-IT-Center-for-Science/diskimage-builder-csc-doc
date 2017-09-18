#!/bin/bash --login
DIB_RELEASE="wheezy"
IMAGE_NAME="Debian-wheezy-server-amd64"
CLOUD_INIT_DEFAULT_USER_NAME="cloud-user"
ELEMENTS="vm cloud-init-cfg debian"
PACKAGES="vim,ntp"
IMAGE_VISIBILITY="public"

export DIB_RELEASE
export CLOUD_INIT_DEFAULT_USER_NAME

source $(dirname $0)/image_create.sh
