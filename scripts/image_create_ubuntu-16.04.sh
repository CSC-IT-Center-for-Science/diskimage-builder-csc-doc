#!/bin/bash --login
DIB_RELEASE="xenial"
IMAGE_NAME="Ubuntu-16.04"
CLOUD_INIT_DEFAULT_USER_NAME="cloud-user"
ELEMENTS="vm cloud-init-cfg ubuntu"
PACKAGES="vim,ntp"
DIB_CLOUD_INIT_DATASOURCES="OpenStack"

export DIB_CLOUD_INIT_DATASOURCES
export DIB_RELEASE
export CLOUD_INIT_DEFAULT_USER_NAME

source $(dirname $0)/image_create.sh
