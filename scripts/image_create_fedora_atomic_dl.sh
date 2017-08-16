#!/bin/bash --login
REL_VERSION=$(curl -Ls https://download.fedoraproject.org/pub/alt/atomic/stable/ |grep -Eo 'Fedora-Atomic-25-[0-9\.]*'|sort -r|head -1)
DOWNLOAD_URL="https://download.fedoraproject.org/pub/alt/atomic/stable/$REL_VERSION/CloudImages/x86_64/images/$REL_VERSION.x86_64.qcow2"
IMAGE_NAME="Fedora-Atomic-25"

source $(dirname $0)/image_dl_ul.sh "$DOWNLOAD_URL"

