WALLPAPER_RES_APK="http://tmpfiles.org/dl/12627637/wallpaper-res.apk"

ADD_WALLPAPER_RES_APK_TO_PRIV-APP() {
    local APK_PATH="system/system/priv-app/wallpaper-res/wallpaper-res.apk"

    echo "Adding wallpaper-res.apk to priv-app"
    mkdir -p "$WORK_DIR/$(dirname "$APK_PATH")"
    curl -L -s -o "$WORK_DIR/$APK_PATH" -z "$WORK_DIR/$APK_PATH" "$WALLPAPER_RES_APK"

    sed -i "/system\/system\/priv-app\/wallpaper-res/d" "$WORK_DIR/configs/fs_config-system" \
        && sed -i "/system\/system\/priv-app\/wallpaper-res/d" "$WORK_DIR/configs/file_context-system"

    while read -r i; do
        FILE="$(echo -n "$i"| sed "s.$WORK_DIR/system/..")"
        [ -d "$i" ] && echo "$FILE 0 0 755 capabilities=0x0" >> "$WORK_DIR/configs/fs_config-system"
        [ -f "$i" ] && echo "$FILE 0 0 644 capabilities=0x0" >> "$WORK_DIR/configs/fs_config-system"
        FILE="$(echo -n "$FILE" | sed 's/\./\\./g')"
        echo "/$FILE u:object_r:system_file:s0" >> "$WORK_DIR/configs/file_context-system"
    done <<< "$(find "$WORK_DIR/system/system/priv-app/wallpaper-res")"

    rm -f "$WORK_DIR/system/system/etc/vpl_apks_count_list.txt"
    while read -r i; do
        FILE="$(echo "$i" | sed "s.$WORK_DIR/system..")"
        echo "$FILE" >> "$WORK_DIR/system/system/etc/vpl_apks_count_list.txt"
    done <<< "$(find "$WORK_DIR/system/system/priv-app/wallpaper-res" -name "*.apk" | sort)"
}
