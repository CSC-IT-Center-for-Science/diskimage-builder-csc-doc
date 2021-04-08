DIB_LOCAL_IMAGE=""
DIB_OPTIONS="--no-tmpfs --qemu-img-options compat=0.10"
IMAGE_SIZE="10"
IMAGE_FORMAT="qcow2"
IMAGE_VISIBILITY="$IMAGE_VISIBILITY"
IMAGE_KEEP_COUNT="250"
TMP_IMAGE_NAME="_tmp_${IMAGE_NAME}_tmp_"
SECURITY_GROUPS="default"
TEST_INSTANCE_NAME="_test_$IMAGE_NAME-$(date +%F)"
TEST_FLAVOR="standard.tiny"
TEST_NET_ID="d5849d3b-f022-45dc-aeb2-0af7a9224b30"
TEST_FIP="193.167.189.254"
TEST_PING_COUNT="5"
TEST_PING_INTERVAL="20"
PYTHONIOENCODING="utf-8"
