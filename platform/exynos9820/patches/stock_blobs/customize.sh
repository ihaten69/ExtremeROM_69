# S25 Ultra OneUI 7 -> SoundBooster 2060
# S10 Series -> SoundBooster 1000
echo "Replacing SoundBooster"
DELETE_FROM_WORK_DIR "system" "system/lib64/lib_SoundBooster_ver2060.so"
ADD_TO_WORK_DIR "$TARGET_FIRMWARE" "system" "system/lib64/lib_SoundBooster_ver1000.so" 0 0 644 "u:object_r:system_lib_file:s0"
ADD_TO_WORK_DIR "$TARGET_FIRMWARE" "system" "system/lib64/libsamsungSoundbooster_plus_legacy.so" 0 0 644 "u:object_r:system_lib_file:s0"

echo "Replacing GameDriver"
DELETE_FROM_WORK_DIR "system" "system/priv-app/GameDriver-SM8750"
ADD_TO_WORK_DIR "$TARGET_FIRMWARE" "system" "system/priv-app/GameDriver-EX9820/GameDriver-EX9820.apk" 0 0 644 "u:object_r:system_file:s0"
ADD_TO_WORK_DIR "$TARGET_FIRMWARE" "system" "system/priv-app/DevGPUDriver-EX9820/DevGPUDriver-EX9820.apk" 0 0 644 "u:object_r:system_file:s0"

MODEL=$(echo -n "$TARGET_FIRMWARE" | cut -d "/" -f 1)
REGION=$(echo -n "$TARGET_FIRMWARE" | cut -d "/" -f 2)

echo "Replacing Hotword"
# Why does 9820 have this in system and not product?
# Now we gotta "hax" the module utils...
DELETE_FROM_WORK_DIR "product" "priv-app/HotwordEnrollmentXGoogleEx6_WIDEBAND_LARGE"
DELETE_FROM_WORK_DIR "product" "priv-app/HotwordEnrollmentYGoogleEx6_WIDEBAND_LARGE"
cp -a --preserve=all "$FW_DIR/${MODEL}_${REGION}/system/system/priv-app/HotwordEnrollmentOKGoogleExCORTEXM4" "$WORK_DIR/product/priv-app"
cp -a --preserve=all "$FW_DIR/${MODEL}_${REGION}/system/system/priv-app/HotwordEnrollmentXGoogleExCORTEXM4" "$WORK_DIR/product/priv-app"

if ! grep -q "HotwordEnrollmentOKGoogleExCORTEXM4" "$WORK_DIR/configs/file_context-product"; then
    {
        echo "/product/priv-app/HotwordEnrollmentOKGoogleExCORTEXM4 u:object_r:system_file:s0"
        echo "/product/priv-app/HotwordEnrollmentOKGoogleExCORTEXM4/HotwordEnrollmentOKGoogleExCORTEXM4\.apk u:object_r:system_file:s0"
        echo "/product/priv-app/HotwordEnrollmentOKGoogleExCORTEXM4/HotwordEnrollmentOKGoogleExCORTEXM4\.apk\.prof u:object_r:system_file:s0"
        echo "/product/priv-app/HotwordEnrollmentXGoogleExCORTEXM4 u:object_r:system_file:s0"
        echo "/product/priv-app/HotwordEnrollmentXGoogleExCORTEXM4/HotwordEnrollmentXGoogleExCORTEXM4\.apk u:object_r:system_file:s0"
        echo "/product/priv-app/HotwordEnrollmentXGoogleExCORTEXM4/HotwordEnrollmentXGoogleExCORTEXM4\.apk\.prof u:object_r:system_file:s0"

    } >> "$WORK_DIR/configs/file_context-product"
fi
if ! grep -q "HotwordEnrollmentOKGoogleExCORTEXM4" "$WORK_DIR/configs/fs_config-product"; then
    {
        echo "product/priv-app/HotwordEnrollmentOKGoogleExCORTEXM4 0 0 755 capabilities=0x0"
        echo "product/priv-app/HotwordEnrollmentOKGoogleExCORTEXM4/HotwordEnrollmentOKGoogleExCORTEXM4.apk 0 0 644 capabilities=0x0"
        echo "product/priv-app/HotwordEnrollmentOKGoogleExCORTEXM4/HotwordEnrollmentOKGoogleExCORTEXM4.apk.prof 0 0 644 capabilities=0x0"
        echo "product/priv-app/HotwordEnrollmentXGoogleExCORTEXM4 0 0 755 capabilities=0x0"
        echo "product/priv-app/HotwordEnrollmentXGoogleExCORTEXM4/HotwordEnrollmentXGoogleExCORTEXM4.apk 0 0 644 capabilities=0x0"
        echo "product/priv-app/HotwordEnrollmentXGoogleExCORTEXM4/HotwordEnrollmentXGoogleExCORTEXM4.apk.prof 0 0 644 capabilities=0x0"
    } >> "$WORK_DIR/configs/fs_config-product"
fi
