echo "Updating Vibrator/RIL/Face/WPA HALs..."
BLOBS_LIST="
bin/hw/vendor.samsung.hardware.vibrator@2.2-service
etc/init/vendor.samsung.hardware.vibrator@2.2-service.rc
lib64/vendor.samsung.hardware.vibrator@2.0.so
lib64/vendor.samsung.hardware.vibrator@2.1.so
lib64/vendor.samsung.hardware.vibrator@2.2.so
"
for blob in $BLOBS_LIST
do
    DELETE_FROM_WORK_DIR "vendor" "$blob"
done

BLOBS_LIST="
bin/hw/vendor.samsung.hardware.biometrics.face@2.0-service
etc/init/vendor.samsung.hardware.biometrics.face@2.0-service.rc
"
for blob in $BLOBS_LIST
do
    DELETE_FROM_WORK_DIR "vendor" "$blob"
done

BLOBS_LIST="
bin/hermesd
etc/init/hermesd.rc
"
for blob in $BLOBS_LIST
do
    DELETE_FROM_WORK_DIR "vendor" "$blob"
done

ADD_TO_WORK_DIR "p3sxxx" "vendor" "." 0 2000 755 "u:object_r:vendor_file:s0"
