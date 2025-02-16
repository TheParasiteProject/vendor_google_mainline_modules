# vendor_google_mainline_modules

## Note for Google Play system updates support

### Reminder

You should fix VINTF entry missing errors, dlopen failures, system app crashes before you proceed.
<br>Otherwise, Google Play system updates will rollbacks all updates or even causing bootloop.
<br>Mostly, rollbacking/bootlooping occurs if you missed adding [VINTF](https://source.android.com/docs/core/architecture/vintf) entries in [Frameworks Compatibility Matrix](https://source.android.com/docs/core/architecture/vintf/comp-matrices) or Device Manifest (or both)
<br>that is not marked as optional or important to operate on your system,
<br>or dlopen failed due to missing blobs/symbols,
<br>or frequent system app crashes (e.g. MIUI Camera app).
<br>For kernel version < 4.19, you might want to apply upstream bpf patches and spoofing.

### Add support for Google Play system updates

First, you need to cherry-pick commit into build/soong.

```sh
git remote add apex https://github.com/TheParasiteProject/build_soong.git && git cherry-pick 3216c45d3b752edd6c8d19fbee311d71dedef7ed
```

You need to include the `config.mk`'s path to your `device.mk`

```M
$(call inherit-product-if-exists, vendor/google/mainline_modules/config.mk)
```

If your device support Google Pixel's Now Playing feature,
<br>you could enable it by setting `TARGET_SUPPORTS_NOW_PLAYING := true` in your `device.mk`.
<br>

If you don't want to/can't support Google Play system updates,
<br>Set `TARGET_SUPPORTS_PREBUILT_UPDATABLE_APEX := false` in your `device.mk`.
<br>This will allows you to use AOSP's source build APEX.

```M
TARGET_SUPPORTS_PREBUILT_UPDATABLE_APEX := false
```

## Initial setup

- Install `xmlstarlet`
  - `sudo apt install xmlstarlet`, `sudo pacman -S xmlstarlet`, etc. depending on your distribution.
- Install `apktool`, make sure its available in PATH
  - https://ibotpeaches.github.io/Apktool/install/
  - Run `apktool if framework-res.apk`, `apktool if SystemUIGoogle.apk` to install framework for apktool.
    <br>This is necessary for proper extracting.
    <br>(generally found in /system/framework/, /system_ext/priv-app/)

## Extracting / updating extracted overlays

Basically the same as regular extract-files

```sh
./extract-files.sh /path/to/a/dump
```

## Removing certain overlays

- If certain overlays are not required, you can simply add them to `exclude-tag.txt`, those will be removed from the extracted overlays.

## Miscellaneous information

- The main changes here are the addition of `apktool` and `xmlstarlet`, to allow us to extract the necessary overlays from some RROs.
- Since the process does take a while, to speed it up, all extraction is done in the background.
  <br>This might not be suitable for weaker systems if there is a very high number of overlays to be extracted.

## Credits

* [DerpFest AOSP](https://github.com/DerpFest-AOSP)
* [hentaiOS](https://github.com/hentaiOS)
* [Jarl-Penguin](https://github.com/JarlPenguin)
* [PixelExperience](https://github.com/PixelExperience)
* [StatiX](https://github.com/StatiXOS)
