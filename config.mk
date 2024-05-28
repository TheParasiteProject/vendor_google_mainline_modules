ifneq ($(WITH_GMS),false)

# Anything including updatable_apex.mk should have done so by now.
ifneq ($(TARGET_SUPPORTS_PREBUILT_UPDATABLE_APEX), false)

DISABLE_DEXPREOPT_CHECK := true

# Setup build characteristics
PRODUCT_INCLUDE_TAGS := com.android.mainline mainline_module_prebuilt_monthly_release

ifneq ($(MAINLINE_INCLUDE_UWB_MODULE), false)
MAINLINE_INCLUDE_UWB_MODULE := true
endif

ifneq ($(MAINLINE_INCLUDE_WIFI_MODULE), false)
MAINLINE_INCLUDE_WIFI_MODULE := true
endif

ifneq ($(MAINLINE_INCLUDE_BTSERVICES_MODULE), false)
MAINLINE_INCLUDE_BTSERVICES_MODULE := true

# Overlay
PRODUCT_PACKAGES += \
    GoogleConfigBluetoothOverlay

# Google Bluetooth Legacy Migration
PRODUCT_PACKAGES += \
    GoogleBluetoothLegacyMigration
endif

ifneq ($(MAINLINE_INCLUDE_VIRT_MODULE), false)
MAINLINE_INCLUDE_VIRT_MODULE := true

$(call inherit-product, packages/modules/Virtualization/apex/product_packages.mk)
PRODUCT_PRODUCT_PROPERTIES += \
    ro.boot.hypervisor.vm.supported=1 \
    ro.boot.hypervisor.protected_vm.supported=1
endif

$(call inherit-product-if-exists, vendor/google/mainline_modules/build/mainline_modules.mk)

ifeq ($(TARGET_SUPPORTS_NOW_PLAYING), true)
PRODUCT_PACKAGES += \
    ApexNowPlayingOverlay
else
PRODUCT_PACKAGES += \
    ApexOverlay
endif

# Overlay
PRODUCT_PACKAGES += \
    ApexSettingsOverlay \
    DocumentsUIGoogleOverlayExtra \
    CaptivePortalLoginOverlayExtra \
    CellBroadcastReceiverOverlayExtra \
    CellBroadcastServiceOverlayExtra \
    GoogleConfigOverlayExtra
endif

endif #WITH_GMS
