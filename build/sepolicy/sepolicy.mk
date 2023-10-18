MAINLINE_INCLUDE_SEPOLICY ?= true
ifeq ($(MAINLINE_INCLUDE_SEPOLICY), true)
SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += \
    vendor/mainline_modules/build/sepolicy/private
endif
