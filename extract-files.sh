#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

DEVICE=common
VENDOR=mainline_modules

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$MY_DIR" ]]; then MY_DIR="$PWD"; fi

ANDROID_ROOT="${MY_DIR}/../.."

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

# Default to sanitizing the vendor folder before extraction
CLEAN_VENDOR=true

KANG=
SECTION=

while [ "${#}" -gt 0 ]; do
    case "${1}" in
        -n | --no-cleanup )
                CLEAN_VENDOR=false
                ;;
        -k | --kang )
                KANG="--kang"
                ;;
        -s | --section )
                SECTION="${2}"; shift
                CLEAN_VENDOR=false
                ;;
        * )
                SRC="${1}"
                ;;
    esac
    shift
done

if [ -z "${SRC}" ]; then
    SRC="adb"
fi

function blob_fixup() {
    case "${1}" in
       product/overlay/*apk)
            starletMagic $1 $2 &
            ;;
    esac
}

function starletMagic() {
            folder=${2/.apk/}
            apktool -q d "$2" -o $folder -f
            rm -rf $2 $folder/{apktool.yml,original,res/values/public.xml,unknown}
            cp ${MY_DIR}/overlay-template.txt $folder/Android.bp
            sed -i "s|dummy|${folder##*/}|g" $folder/Android.bp
            find $folder -type f -name AndroidManifest.xml -exec sed -i "s|extractNativeLibs\=\"false\"|extractNativeLibs\=\"true\"|g" {} \;
            for file in $(find $folder/res -name *xml ! -path "$folder/res/raw" ! -path "$folder/res/drawable*" ! -path "$folder/res/xml"); do
                for tag in $(cat exclude-tag.txt); do
                    type=$(echo $tag | cut -d: -f1)
                    node=$(echo $tag | cut -d: -f2)
                    xmlstarlet ed -L -d "/resources/$type[@name="\'$node\'"]" $file
                    xmlstarlet fo -s 4 $file > $file.bak
                    mv $file.bak $file
                done
                sed -i "s|\?android:\^attr-private|\@\*android\:attr|g" $file
                sed -i "s|\@android\:color|\@\*android\:color|g" $file
                sed -i "s|\^attr-private|attr|g" $file
            done
            if [ "${folder##*/}" == "SettingsGoogleOverlayPixel2022" ]; then
                sed -i "s| android\:resourcesMap\=\"\@xml\/overlays\"||g" "$folder/AndroidManifest.xml"
                rm -rf "$folder/res/xml"
            fi
}

if [ -z "$SRC" ]; then
    echo "Path to system dump not specified! Specify one with --path"
    exit 1
fi

# Initialize the helper
setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" false "${CLEAN_VENDOR}"

extract "${MY_DIR}/proprietary-files.txt" "${SRC}" "${KANG}" --section "${SECTION}"

rm -Rf "${MY_DIR}/${DEVICE}/proprietary/system/apex"
mv "${MY_DIR}/${DEVICE}/proprietary/system/system/apex" "${MY_DIR}/${DEVICE}/proprietary/system/apex"

"${MY_DIR}/setup-makefiles.sh"

echo "Waiting for extraction"
wait
echo "All done"
