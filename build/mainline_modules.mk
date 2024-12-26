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
#   MAINLINE_INCLUDE_DEVICELOCK_MODULE := true or false
#   - when it is true, DEVICELOCK module will be added to PRODUCT_PACKAGES
#   MAINLINE_INCLUDE_RKP_MODULE := true or false
#   - when it is true, RKP module will be added to PRODUCT_PACKAGES
#   MAINLINE_INCLUDE_TETHERING_MODULE := true or false
#   - when it is true, TETHERING module will be added to PRODUCT_PACKAGES
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
    vendor/google/mainline_modules/common

# Mainline modules - APK type
PRODUCT_PACKAGES += \
    ModuleMetadataGoogle \
    DocumentsUIGoogle \
    CaptivePortalLoginGoogle \
    HelpRtcPrebuilt \
    PrebuiltGoogleAdservicesTvp \
    PrebuiltGoogleTelemetryTvp

# Ingesting networkstack.x509.pem
PRODUCT_MAINLINE_SEPOLICY_DEV_CERTIFICATES=vendor/google/mainline_modules/build/certificates

# Additional sepolicies
-include vendor/google/mainline_modules/build/sepolicy/sepolicy.mk

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
    GoogleMediaProviderOverlay

ifeq ($(TARGET_SUPPORTS_GOOGLE_NETWORK_STACK),true)
PRODUCT_PACKAGES += \
    NetworkStackGoogle
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/priv-app/NetworkStackGoogle/NetworkStackGoogle.apk

PRODUCT_PACKAGES += \
    GoogleNetworkStackOverlay

# CellBroadcast
PRODUCT_PACKAGES += \
    CellBroadcastReceiverOverlay \
    CellBroadcastServiceOverlay

PRODUCT_PACKAGES += \
    com.google.android.cellbroadcast
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/apex/com.google.android.cellbroadcast.apex

# sysconfig files
PRODUCT_PACKAGES += \
    GoogleCellBroadcast_config.xml

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/etc/permissions/GoogleCellBroadcast_config.xml

# Additional Overlays
PRODUCT_PACKAGES += \
    PartnerModulesSettingsOverlay
endif

# Additional Overlays
PRODUCT_PACKAGES += \
    PartnerModulesPermissionControllerOverlay

# Configure APEX as updatable
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# Mainline modules - APEX type
PRODUCT_PACKAGES += \
    com.google.mainline.primary.libs \
    com.google.android.tzdata6

# adding compressed APEX based on options

# module_sdk and optional modules

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
PRODUCT_PACKAGES += \
    com.google.android.btservices
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/apex/com.google.android.btservices.apex
endif

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

# Optional DeviceLock
MAINLINE_INCLUDE_DEVICELOCK_MODULE ?= false
ifeq ($(MAINLINE_INCLUDE_DEVICELOCK_MODULE),true)
PRODUCT_PACKAGES += \
    com.google.android.devicelock
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/apex/com.google.android.devicelock.apex
endif

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

# Optional Nfc
MAINLINE_INCLUDE_NFCSERVICES_MODULE ?= false
ifeq ($(MAINLINE_INCLUDE_NFCSERVICES_MODULE),true)
PRODUCT_PACKAGES += \
    com.google.android.nfcservices
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/apex/com.google.android.nfcservices.apex
endif

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

# Optional Profiling
MAINLINE_INCLUDE_PROFILING_MODULE ?= false
ifeq ($(MAINLINE_INCLUDE_PROFILING_MODULE),true)
PRODUCT_PACKAGES += \
    com.google.android.profiling
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/apex/com.google.android.profiling.capex
endif

# Optional RemoteKeyProvisioning
MAINLINE_INCLUDE_RKP_MODULE ?= false
ifeq ($(MAINLINE_INCLUDE_RKP_MODULE),true)
PRODUCT_PACKAGES += \
    com.google.android.rkpd
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/apex/com.google.android.rkpd.apex
endif

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

# Optional Tethering
MAINLINE_INCLUDE_TETHERING_MODULE ?= false
ifeq ($(MAINLINE_INCLUDE_TETHERING_MODULE),true)
PRODUCT_PACKAGES += \
    com.google.android.tethering
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/apex/com.google.android.tethering.apex
endif

# Optional Uwb
MAINLINE_INCLUDE_UWB_MODULE ?= false
ifeq ($(MAINLINE_INCLUDE_UWB_MODULE),true)
PRODUCT_PACKAGES += \
    com.google.android.uwb
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/apex/com.google.android.uwb.apex
endif

# Optional Vitualization
MAINLINE_INCLUDE_VIRT_MODULE ?= false
ifeq ($(MAINLINE_INCLUDE_VIRT_MODULE),true)
PRODUCT_PACKAGES += \
    com.google.android.virt
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/apex/com.google.android.virt.apex

PRODUCT_PACKAGES += \
    com.google.android.compos
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system_ext/apex/com.google.android.compos.apex
endif

# Optional WiFi
MAINLINE_INCLUDE_WIFI_MODULE ?= false
ifeq ($(MAINLINE_INCLUDE_WIFI_MODULE),true)
PRODUCT_PACKAGES += \
    com.google.android.wifi
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/apex/com.google.android.wifi.apex
endif

# sysconfig files
PRODUCT_PACKAGES += \
    google-install-constraints-package-allowlist.xml \
    google-staged-installer-whitelist.xml \
    GoogleDocumentsUI_permissions.xml \
    GoogleNetworkStack_permissions.xml \
    preinstalled-packages-com.google.android.providers.media.module.xml

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/apex/com.google.mainline.primary.libs.apex \
    system/priv-app/DocumentsUIGoogle/DocumentsUIGoogle.apk \
    system/app/CaptivePortalLoginGoogle/CaptivePortalLoginGoogle.apk \
    system/etc/permissions/GoogleDocumentsUI_permissions.xml \
    system/etc/permissions/GoogleExtServices_permissions.xml \
    system/etc/permissions/GoogleNetworkStack_permissions.xml \
    system/etc/permissions/GooglePermissionController_permissions.xml \
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
