echo "Removing UWB HAL from vendor"

BLOBS_LIST="
bin/hw/vendor.samsung.hardware.uwb@1.0-service
etc/uwb_key
etc/libuwb-nxp.conf
etc/libuwb-uci.conf
etc/init/init.vendor.uwb.rc
etc/permissions/android.hardware.uwb.xml
etc/permissions/samsung.hardware.uwb.xml
etc/vintf/manifest/uwb-service.xml
"
for blob in $BLOBS_LIST
do
    DELETE_FROM_WORK_DIR "vendor" "$blob"
done