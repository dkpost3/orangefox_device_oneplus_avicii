#
# Copyright (C) 2022 The Android Open Source Project
# Copyright (C) 2022 OrangeFox Recovery Project 
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := device/oneplus/avicii

# A/B support
AB_OTA_UPDATER := true

# fscrypt policy
TW_USE_FSCRYPT_POLICY := 1

# GMS Client ID
PRODUCT_GMS_CLIENTID_BASE := android-qualcomm

# A/B updater updatable partitions list. Keep in sync with the partition list
# with "_a" and "_b" variants in the device. Note that the vendor can add more
# more partitions to this list for the bootloader and radio.
AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    odm \
    product \
    recovery \
    system \
    system_ext \
    vbmeta \
    vbmeta_system \
    vendor

PRODUCT_PACKAGES += \
    otapreopt_script \
    update_engine \
    update_engine_sideload \
    update_verifier

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

# tell update_engine to not change dynamic partition table during updates
# needed since our qti_dynamic_partitions does not include
# vendor and odm and we also dont want to AB update them
TARGET_ENFORCE_AB_OTA_PARTITION_LIST := true

# API
PRODUCT_SHIPPING_API_LEVEL := 29

# Boot control HAL
PRODUCT_PACKAGES += \
    android.hardware.boot@1.1-impl \
    android.hardware.boot@1.1-service \
    android.hardware.boot@1.1-impl-qti.recovery \
    bootctrl.$(PRODUCT_PLATFORM).recovery \
    bootctrl.$(PRODUCT_PLATFORM)
    
PRODUCT_PACKAGES_DEBUG += \
    bootctl
        
# Health HAL
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl.recovery


# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.0-impl-mock \
    fastbootd

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# qcom ncryption
PRODUCT_PACKAGES += \
    qcom_decrypt \
    qcom_decrypt_fbe 

# tzdata
PRODUCT_PACKAGES_ENG += \
    tzdata_twrp


ifeq ($(FOX_VARIANT),FBEv2)

# fscrypt policy
TW_USE_FSCRYPT_POLICY := 2

# Properties
PRODUCT_PROPERTY_OVERRIDES += \
        ro.crypto.allow_encrypt_override=true \
	ro.crypto.dm_default_key.options_format.version=2 \
	ro.crypto.volume.filenames_mode=aes-256-cts \
	ro.crypto.volume.metadata.method=dm-default-key \
	ro.crypto.volume.options=::v2
 
endif

# OEM otacert
PRODUCT_EXTRA_RECOVERY_KEYS += \
    $(LOCAL_PATH)/security/local_OTA \
    $(LOCAL_PATH)/security/pixelexperience
# APEX libraries    
PRODUCT_COPY_FILES += \
    $(OUT_DIR)/target/product/$(PRODUCT_RELEASE_NAME)/obj/SHARED_LIBRARIES/libandroidicu_intermediates/libandroidicu.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libcuuc.so
