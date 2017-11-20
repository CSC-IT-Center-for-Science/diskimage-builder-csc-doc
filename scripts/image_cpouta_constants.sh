DIB_LOCAL_IMAGE=""
DIB_OPTIONS="--no-tmpfs --qemu-img-options compat=0.10"
IMAGE_SIZE="10"
IMAGE_FORMAT="qcow2"
IMAGE_VISIBILITY="$IMAGE_VISIBILITY"
IMAGE_KEEP_COUNT="25"
TMP_IMAGE_NAME="_tmp_$IMAGE_NAME"
SECURITY_GROUPS="default"
TEST_INSTANCE_NAME="_test_$IMAGE_NAME-$(date +%F)"
TEST_FLAVOR="standard.tiny"
TEST_NET_ID="63b53b45-3e3f-454c-8a27-d1bfae422c11"
TEST_FIP="86.50.170.201"
TEST_PING_COUNT="5"
TEST_PING_INTERVAL="20"
PYTHONIOENCODING="utf-8"
