#!/bin/bash -lv
DISTRO_NAME="centos7"
IMAGE_NAME="CentOS-7-GPU"
CLOUD_INIT_DEFAULT_USER_NAME="cloud-user"
ELEMENTS="vm cloud-init-cfg centos7 nvidia-cuda"
PACKAGES="vim,ntp,deltarpm,cuda"
IMAGE_VISIBILITY="private"

export CLOUD_INIT_DEFAULT_USER_NAME

source $(dirname $0)/image_create.sh

