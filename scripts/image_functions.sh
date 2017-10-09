#!/bin/bash
export PYTHONIOENCODING

function cleanup() {
	find . -name "${IMAGE_NAME}*.d" -type d -exec rm -rf {} + 2>/dev/null
    find . -name "${IMAGE_NAME}*.qcow2" -type f -exec rm -f {} + 2>/dev/null
	# delete any orphaned temporary images using image_id
	for id in $(glance image-list | grep "$TMP_IMAGE_NAME" | awk '{print $2}')
	do
		glance image-delete "$id" &>/dev/null || true
	done
	# delete any orphaned test instance using instance_id
	for id in $(nova list | grep "$TEST_INSTANCE_NAME" | awk '{print $2}')
	do
		nova delete "$id" &>/dev/null || true
	done
}

function image_create() {
	# create cloud image with diskimage-builder
	TMP_DIR=~/temp disk-image-create $DIB_OPTIONS -o "$IMAGE_NAME" \
	    --image-size "$IMAGE_SIZE" -p "$PACKAGES" $ELEMENTS
}

function image_download() {
    curl -L -o ${IMAGE_NAME}.qcow2 "$1"
}

function image_test() {
    echo "Creating test image $TMP_IMAGE_NAME"
    # create new temporary image
    if [ -z "${OS_DISTRO_PROPERTY:-}" ]; then
        OS_DISTRO_PROPERTY=""
    fi
    glance image-create --name "$TMP_IMAGE_NAME" --container-format bare \
        --disk-format "$IMAGE_FORMAT" --visibility private --progress \
        --file "${IMAGE_NAME}.${IMAGE_FORMAT}" \
        --property os_distro="$OS_DISTRO_PROPERTY"
    echo "Creating test instance $TEST_INSTANCE_NAME"
    # create new test instance
    nova boot --flavor "$TEST_FLAVOR" --image "$TMP_IMAGE_NAME"\
        --nic net-id="$TEST_NET_ID" --poll "$TEST_INSTANCE_NAME"
    # assign floating IP to test instance for cPouta
    if [[ -v  "${TEST_FIP+x}" ]]; then
        echo "Assigning floating IP $TEST_FIP to $TEST_INSTANCE_NAME"
        nova floating-ip-associate "$TEST_INSTANCE_NAME" "$TEST_FIP"
        ping -qA -c"$TEST_PING_COUNT" -i"$TEST_PING_INTERVAL" "$TEST_FIP"
    fi
}

function image_deploy() {
    # set older versions non-public or skip if a new image
    images=($(glance image-list --property owner="$OS_TENANT_ID" --property\
        name="$IMAGE_NAME" | grep "$IMAGE_NAME" | awk -F'| ' '{print $2}'))
    images=${images:-}
    if [[ "${images:-}" ]]; then
        for image in ${images[@]}; do
            echo "Setting non-public: $image"
            glance image-update  --visibility private $image
        done
    fi
    # rename new image
    echo "Renaming $TMP_IMAGE_NAME to $IMAGE_NAME"
    glance image-update --name "$IMAGE_NAME" \
        --property description="All packages of this image were updated on $(date +%F)" \
        --visibility "$IMAGE_VISIBILITY" \
        $(glance image-list | grep "$TMP_IMAGE_NAME" | cut -d '|' -f2)
}

function delete_old_image_versions() {
    images=($(glance image-list --sort-key created_at --sort-dir desc\
        --property owner="$OS_TENANT_ID" --property name="$IMAGE_NAME"\
        | grep "$IMAGE_NAME" | awk -F'|' '{print $2}'))
    images=${images:-}

    for delete in "${images[@]:$IMAGE_KEEP_COUNT}"; do
        echo "Deleting image: $delete"
        glance image-delete "$delete"
    done
}
