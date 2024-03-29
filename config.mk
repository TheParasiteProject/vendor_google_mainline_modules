# Anything including updatable_apex.mk should have done so by now.
ifneq ($(TARGET_SUPPORTS_PREBUILT_UPDATABLE_APEX), false)

# FIXME -- DeviceLock ModulePrebuilt is only planned to be released for QPR2
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

MAINLINE_INCLUDE_VIRT_MODULE ?= false
ifneq ($(MAINLINE_INCLUDE_VIRT_MODULE), false)
MAINLINE_INCLUDE_VIRT_MODULE := true
endif

$(call inherit-product-if-exists, vendor/mainline_modules/build/mainline_modules.mk)

# Overlay
PRODUCT_PACKAGES += \
	ApexOverlay \
	ApexSettingsOverlay \
	DocumentsUIGoogleOverlayExtra \
	CaptivePortalLoginOverlayExtra \
	CellBroadcastReceiverOverlayExtra \
	CellBroadcastServiceOverlayExtra \
	GoogleConfigOverlayExtra
endif
