ifneq ($(WITH_GMS),false)

# Anything including updatable_apex.mk should have done so by now.
ifneq ($(TARGET_SUPPORTS_PREBUILT_UPDATABLE_APEX), false)

DISABLE_DEXPREOPT_CHECK := true

# Disable enforce-product-packages-exist check
TARGET_DISABLE_EPPE := true

# Setup build characteristics
PRODUCT_INCLUDE_TAGS := com.android.mainline mainline_module_prebuilt_monthly_release

# Certificate customisation
TARGET_MAINLINE_APEX_CERTIFICATE_DIR := $(abspath $(TOP)/vendor/google/mainline_modules/build/certificates)
TARGET_GOOGLE_APEX_CERTIFICATE_DIR := $(abspath $(TOP)/vendor/google/mainline_modules/build/certificates-google)
TARGET_AOSP_APEX_CERTIFICATE_DIR := $(abspath $(TOP)/build/target/product/security)
TARGET_CUSTOM_APEX_CERTIFICATE_DIR ?= $(TARGET_AOSP_APEX_CERTIFICATE_DIR)

TARGET_CUSTOM_NFC_CERTIFICATE_DIR ?= $(TARGET_GOOGLE_APEX_CERTIFICATE_DIR)
$(shell ln -sfn \
    $(TARGET_CUSTOM_NFC_CERTIFICATE_DIR)/nfc.x509.pem \
    $(TARGET_MAINLINE_APEX_CERTIFICATE_DIR)/nfc.x509.pem)

TARGET_CUSTOM_SDK_SANDBOX_CERTIFICATE_DIR ?= $(TARGET_GOOGLE_APEX_CERTIFICATE_DIR)
$(shell ln -sfn \
    $(TARGET_CUSTOM_SDK_SANDBOX_CERTIFICATE_DIR)/sdk_sandbox.x509.pem \
    $(TARGET_MAINLINE_APEX_CERTIFICATE_DIR)/sdk_sandbox.x509.pem)

ifneq ($(TARGET_SUPPORTS_GOOGLE_NETWORK_STACK), false)
TARGET_SUPPORTS_GOOGLE_NETWORK_STACK := true
TARGET_CUSTOM_NETWORK_STACK_CERTIFICATE_DIR := $(TARGET_GOOGLE_APEX_CERTIFICATE_DIR)
else
TARGET_CUSTOM_NETWORK_STACK_CERTIFICATE_DIR ?= $(TARGET_CUSTOM_APEX_CERTIFICATE_DIR)
endif #TARGET_SUPPORTS_GOOGLE_NETWORK_STACK
$(shell ln -sfn \
    $(TARGET_CUSTOM_NETWORK_STACK_CERTIFICATE_DIR)/networkstack.x509.pem \
    $(TARGET_MAINLINE_APEX_CERTIFICATE_DIR)/networkstack.x509.pem)

ifneq ($(MAINLINE_INCLUDE_DEVICELOCK_MODULE), false)
MAINLINE_INCLUDE_DEVICELOCK_MODULE := true
endif #MAINLINE_INCLUDE_DEVICELOCK_MODULE

ifneq ($(MAINLINE_INCLUDE_TETHERING_MODULE), false)
MAINLINE_INCLUDE_TETHERING_MODULE := true
endif #MAINLINE_INCLUDE_TETHERING_MODULE

ifneq ($(MAINLINE_INCLUDE_RKP_MODULE), false)
MAINLINE_INCLUDE_RKP_MODULE := true
endif #MAINLINE_INCLUDE_RKP_MODULE

ifneq ($(MAINLINE_INCLUDE_UWB_MODULE), false)
MAINLINE_INCLUDE_UWB_MODULE := true
endif #MAINLINE_INCLUDE_UWB_MODULE

ifneq ($(MAINLINE_INCLUDE_WIFI_MODULE), false)
MAINLINE_INCLUDE_WIFI_MODULE := true
endif #MAINLINE_INCLUDE_WIFI_MODULE

ifneq ($(MAINLINE_INCLUDE_BTSERVICES_MODULE), false)
MAINLINE_INCLUDE_BTSERVICES_MODULE := true

# Overlay
PRODUCT_PACKAGES += \
    GoogleConfigBluetoothOverlay

# Google Bluetooth Legacy Migration
PRODUCT_PACKAGES += \
    GoogleBluetoothLegacyMigration

TARGET_CUSTOM_BLUETOOTH_CERTIFICATE_DIR := $(TARGET_GOOGLE_APEX_CERTIFICATE_DIR)
else
TARGET_CUSTOM_BLUETOOTH_CERTIFICATE_DIR ?= $(TARGET_CUSTOM_APEX_CERTIFICATE_DIR)
endif #MAINLINE_INCLUDE_BTSERVICES_MODULE
$(shell ln -sfn \
    $(TARGET_CUSTOM_BLUETOOTH_CERTIFICATE_DIR)/bluetooth.x509.pem \
    $(TARGET_MAINLINE_APEX_CERTIFICATE_DIR)/bluetooth.x509.pem)

ifneq ($(MAINLINE_INCLUDE_VIRT_MODULE), false)
MAINLINE_INCLUDE_VIRT_MODULE := true

$(call inherit-product, packages/modules/Virtualization/apex/product_packages.mk)
PRODUCT_PRODUCT_PROPERTIES += \
    ro.boot.hypervisor.vm.supported=1 \
    ro.boot.hypervisor.protected_vm.supported=1
endif #MAINLINE_INCLUDE_VIRT_MODULE

$(call inherit-product-if-exists, vendor/google/mainline_modules/build/mainline_modules.mk)

ifeq ($(TARGET_SUPPORTS_NOW_PLAYING), true)
PRODUCT_PACKAGES += \
    ApexNowPlayingOverlay
else
PRODUCT_PACKAGES += \
    ApexOverlay
endif #TARGET_SUPPORTS_NOW_PLAYING

# Overlay
PRODUCT_PACKAGES += \
    DocumentsUIGoogleOverlayExtra \
    CaptivePortalLoginOverlayExtra \
    CellBroadcastReceiverOverlayExtra \
    CellBroadcastServiceOverlayExtra

endif #TARGET_SUPPORTS_PREBUILT_UPDATABLE_APEX

endif #WITH_GMS
