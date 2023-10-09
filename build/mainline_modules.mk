#
# Copyright 2022 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Mainline configuration for regular devices that
#   are not low RAM and
#   can support updatable APEX
#
# Flags for partners:
#   MODULE_BUILD_FROM_SOURCE := true or false
#   - controls whether to build Mainline modules from source or not
#   MAINLINE_INCLUDE_UWB_MODULE := true or false
#   - when it is true, UWB module will be added to PRODUCT_PACKAGES
#   MAINLINE_INCLUDE_WIFI_MODULE := true or false
#   - when it is true, WiFi module will be added to PRODUCT_PACKAGES
#   MAINLINE_INCLUDE_BLUETOOTH_MODULE := true or false
#   - when it is true, Bluetooth module will be added to PRODUCT_PACKAGES
#   - if not defined, per-module option will be used
#   MAINLINE_COMPRESS_APEX_<module> := true or false
#   - per-module option that controls whether to use compresssed variant
#

PRODUCT_SOONG_NAMESPACES += \
    vendor/mainline_modules/common

# Mainline modules - APK type
PRODUCT_PACKAGES += \
    ModuleMetadataGoogle \
    DocumentsUIGoogle \
    CaptivePortalLoginGoogle \
    NetworkStackGoogle \
    HelpRtcPrebuilt \
    PrebuiltGoogleAdservicesTvp \
    PrebuiltGoogleTelemetryTvp

# Ingesting networkstack.x509.pem
PRODUCT_MAINLINE_SEPOLICY_DEV_CERTIFICATES=vendor/mainline_modules/build/certificates

# Overlay packages for APK-type modules
PRODUCT_PACKAGES += \
    GoogleDocumentsUIOverlay \
    ModuleMetadataGoogleOverlay \
    GooglePermissionControllerFrameworkOverlay \
    GoogleExtServicesConfigOverlay \
    CaptivePortalLoginOverlay \
    CaptivePortalLoginFrameworkOverlay

# Overlay packages for APEX-type modules
PRODUCT_PACKAGES += \
    CellBroadcastReceiverOverlay \
    CellBroadcastServiceOverlay \
    GoogleMediaProviderOverlay

# Additional Overlays
PRODUCT_PACKAGES += \
    PartnerModulesSettingsOverlay \
    PartnerModulesPermissionControllerOverlay

# Configure APEX as updatable
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# Mainline modules - APEX type
PRODUCT_PACKAGES += \
    com.google.mainline.primary.libs \
    com.google.android.tzdata5

# adding compressed APEX based on options

# module_sdk and optional modules
MODULE_BUILD_FROM_SOURCE ?= false

SOONG_CONFIG_NAMESPACES += wifi_module
SOONG_CONFIG_wifi_module += source_build
SOONG_CONFIG_wifi_module_source_build := true

SOONG_CONFIG_NAMESPACES += uwb_module
SOONG_CONFIG_uwb_module += source_build
SOONG_CONFIG_uwb_module_source_build := true

SOONG_CONFIG_NAMESPACES += btservices_module
SOONG_CONFIG_btservices_module += source_build
SOONG_CONFIG_btservices_module_source_build := true

SOONG_CONFIG_NAMESPACES += virt_module
SOONG_CONFIG_virt_module += source_build
SOONG_CONFIG_virt_module_source_build := true

# Adbd
PRODUCT_PACKAGES += \
    com.google.android.adbd
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/apex/com.google.android.adbd.apex

# AdServices
PRODUCT_PACKAGES += \
    com.google.android.adservices
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/apex/com.google.android.adservices.apex

# AppSearch
PRODUCT_PACKAGES += \
    com.google.android.appsearch
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/apex/com.google.android.appsearch.apex

# Art
PRODUCT_PACKAGES += \
    com.google.android.art
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/apex/com.google.android.art.apex

# Optional Bluetooth
MAINLINE_INCLUDE_BTSERVICES_MODULE ?= false
ifeq ($(MAINLINE_INCLUDE_BTSERVICES_MODULE),true)
SOONG_CONFIG_btservices_module_source_build := false

PRODUCT_PACKAGES += \
    com.google.android.btservices
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/apex/com.google.android.btservices.apex
endif

# CellBroadcast
PRODUCT_PACKAGES += \
    com.google.android.cellbroadcast
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/apex/com.google.android.cellbroadcast.apex

# Conscrypt
PRODUCT_PACKAGES += \
    com.google.android.conscrypt
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/apex/com.google.android.conscrypt.apex

# ConfigInfraStructure
PRODUCT_PACKAGES += \
    com.google.android.configinfrastructure
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/apex/com.google.android.configinfrastructure.apex

# DNS Resolver
PRODUCT_PACKAGES += \
    com.google.android.resolv
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/apex/com.google.android.resolv.apex

# DeviceLock
PRODUCT_PACKAGES += \
    com.google.android.devicelock
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/apex/com.google.android.devicelock.apex

# ExtServices - apex
PRODUCT_PACKAGES += \
    com.google.android.extservices
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/apex/com.google.android.extservices.apex

# HealthFitness
PRODUCT_PACKAGES += \
    com.google.android.healthfitness
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/apex/com.google.android.healthfitness.apex

# Ipsec
PRODUCT_PACKAGES += \
    com.google.android.ipsec
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/apex/com.google.android.ipsec.apex

# Media
PRODUCT_PACKAGES += \
    com.google.android.media
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/apex/com.google.android.media.apex

# MediaProvider
PRODUCT_PACKAGES += \
    com.google.android.mediaprovider
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/apex/com.google.android.mediaprovider.apex

# MediaSwCodec
PRODUCT_PACKAGES += \
    com.google.android.media.swcodec
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/apex/com.google.android.media.swcodec.apex

# Neural Networks
PRODUCT_PACKAGES += \
    com.google.android.neuralnetworks
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/apex/com.google.android.neuralnetworks.apex

# OnDevicePersonalization
PRODUCT_PACKAGES += \
    com.google.android.ondevicepersonalization
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/apex/com.google.android.ondevicepersonalization.apex

# Statsd
PRODUCT_PACKAGES += \
    com.google.android.os.statsd
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/apex/com.google.android.os.statsd.apex

# Permission
PRODUCT_PACKAGES += \
    com.google.android.permission
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/apex/com.google.android.permission.apex

# RemoteKeyProvisioning
PRODUCT_PACKAGES += \
    com.google.android.rkpd
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/apex/com.google.android.rkpd.apex

# Scheduling
PRODUCT_PACKAGES += \
    com.google.android.scheduling
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/apex/com.google.android.scheduling.apex

# SdkExtensions
PRODUCT_PACKAGES += \
    com.google.android.sdkext
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/apex/com.google.android.sdkext.apex

# Tethering
PRODUCT_PACKAGES += \
    com.google.android.tethering
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/apex/com.google.android.tethering.apex

# Optional Uwb
MAINLINE_INCLUDE_UWB_MODULE ?= false
ifeq ($(MAINLINE_INCLUDE_UWB_MODULE),true)
SOONG_CONFIG_uwb_module_source_build := false

PRODUCT_PACKAGES += \
    com.google.android.uwb
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/apex/com.google.android.uwb.apex
endif

# Optional Vitualization
MAINLINE_INCLUDE_VIRT_MODULE ?= false
ifeq ($(MAINLINE_INCLUDE_VIRT_MODULE),true)
SOONG_CONFIG_virt_module_source_build := false

PRODUCT_PACKAGES += \
    com.google.android.virt
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/apex/com.google.android.virt.apex
endif

# Optional WiFi
MAINLINE_INCLUDE_WIFI_MODULE ?= false
ifeq ($(MAINLINE_INCLUDE_WIFI_MODULE),true)
SOONG_CONFIG_wifi_module_source_build := false

PRODUCT_PACKAGES += \
    com.google.android.wifi
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/apex/com.google.android.wifi.apex

PRODUCT_PACKAGES += \
    GoogleConnectivityOverlay \
    GoogleNetworkStackOverlay \
    GoogleTetheringOverlay
endif

# sysconfig files
PRODUCT_PACKAGES += \
    google-staged-installer-whitelist.xml

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/apex/com.google.mainline.primary.libs.apex \
    system/priv-app/DocumentsUIGoogle/DocumentsUIGoogle.apk \
    system/priv-app/NetworkStackGoogle/NetworkStackGoogle.apk \
    system/app/CaptivePortalLoginGoogle/CaptivePortalLoginGoogle.apk \
    system/etc/permissions/GoogleDocumentsUI_permissions.xml \
    system/etc/permissions/GoogleNetworkStack_permissions.xml \
    system/etc/sysconfig/preinstalled-packages-com.google.android.providers.media.module.xml \
    system/apex/com.google.android.tzdata5.apex

# arm
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/framework/arm/%.art \
    system/framework/arm/%.oat \
    system/framework/arm/%.vdex \
    system/framework/arm64/%.art \
    system/framework/arm64/%.oat \
    system/framework/arm64/%.vdex

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/framework/oat/arm/%.odex \
    system/framework/oat/arm/%.vdex \
    system/framework/oat/arm64/%.odex \
    system/framework/oat/arm64/%.vdex
