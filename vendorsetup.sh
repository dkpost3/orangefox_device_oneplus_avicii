#
# Copyright (C) 2022 The OrangeFox Recovery Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

FDEVICE="avicii"
#set -o xtrace

fox_get_target_device() {
local chkdev=$(echo "$BASH_SOURCE" | grep -w $FDEVICE)
   if [ -n "$chkdev" ]; then 
      FOX_BUILD_DEVICE="$FDEVICE"
   else
      chkdev=$(set | grep BASH_ARGV | grep -w $FDEVICE)
      [ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"
   fi
}

if [ -z "$1" -a -z "$FOX_BUILD_DEVICE" ]; then
   fox_get_target_device
fi

if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then
   	export TW_DEFAULT_LANGUAGE="en"
	export LC_ALL="C"
	export FOX_DEVICE="avicii"
	export OF_AB_DEVICE_WITH_RECOVERY_PARTITION=1
 	export ALLOW_MISSING_DEPENDENCIES=true
	export OF_AB_DEVICE=1
	export TARGET_DEVICE_ALT="Nord,oneplusnord,OnePlusNord,OneplusNord,OnePlusnord,Oneplusnord,nord"
	export FOX_RECOVERY_SYSTEM_PARTITION="/dev/block/mapper/system"
	export FOX_RECOVERY_VENDOR_PARTITION="/dev/block/mapper/vendor"
	export OF_USE_GREEN_LED=0
	export OF_IGNORE_LOGICAL_MOUNT_ERRORS=1
	export OF_DONT_PATCH_ENCRYPTED_DEVICE=1
	export FOX_REPLACE_TOOLBOX_GETPROP=1
	export OF_FBE_METADATA_MOUNT_IGNORE=1

	export OF_USE_MAGISKBOOT=1
	export OF_USE_MAGISKBOOT_FOR_ALL_PATCHES=1
	export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1
	export OF_NO_TREBLE_COMPATIBILITY_CHECK=1
	export OF_NO_MIUI_PATCH_WARNING=1
	export FOX_USE_BASH_SHELL=1
	export FOX_ASH_IS_BASH=1
	export FOX_USE_SPECIFIC_MAGISK_ZIP=~/recovery/fox/Magisk/Magisk-v25.2.zip
	export FOX_USE_TAR_BINARY=1
	export FOX_USE_SED_BINARY=1
	export FOX_USE_XZ_UTILS=1
	export OF_SKIP_MULTIUSER_FOLDERS_BACKUP=1
    	export OF_QUICK_BACKUP_LIST="/boot;/data;"
    	export FOX_DELETE_AROMAFM=1
    	export FOX_USE_BASH_SHELL=1
	export FOX_ASH_IS_BASH=1
	export FOX_USE_TAR_BINARY=1
	export FOX_USE_SED_BINARY=1
	export FOX_USE_XZ_UTILS=1
	export OF_ENABLE_LPTOOLS=1
    	export FOX_BUGGED_AOSP_ARB_WORKAROUND="1546300800"; # Tuesday, January 1, 2019 12:00:00 AM GMT+00:00
    	export FOX_ENABLE_APP_MANAGER=1
    	export FOX_USE_NANO_EDITOR=1
    	export FOX_DISABLE_APP_MANAGER=1
    	
    	# run a process after formatting data to recreate /data/media/0 (only when forced-encryption is being disabled)
	export OF_RUN_POST_FORMAT_PROCESS=1

	# ensure that /sdcard is bind-unmounted before f2fs data repair or format (required for FBE v1)
	export OF_UNBIND_SDCARD_F2FS=1

    	
    	# OTA
    	export OF_KEEP_DM_VERITY=1
    	export OF_SUPPORT_ALL_BLOCK_OTA_UPDATES=1
    	export OF_FIX_OTA_UPDATE_MANUAL_FLASH_ERROR=1
    	export OF_DISABLE_MIUI_OTA_BY_DEFAULT=1

	# Screen Settings
	export OF_SCREEN_H=2400
	export OF_STATUS_H=144
	export OF_STATUS_INDENT_LEFT=270
	export OF_STATUS_INDENT_RIGHT=48
	export OF_ALLOW_DISABLE_NAVBAR=0
	export OF_CLOCK_POS=1
	
	# R11.1 Settings
	export FOX_VERSION="R11.1_3"
	export OF_MAINTAINER="Sreeshankar K"
	
	# disable wrappedkey?
	if [ "$FOX_VARIANT" = "FBEv1_NOWRAP" ]; then
	   export OF_DISABLE_WRAPPEDKEY=1
	fi

	if [ "$FOX_VARIANT" = "FBEv2" ]; then
	   export OF_PATCH_AVB20=0
	else
	   export OF_PATCH_AVB20=1
	fi

	# let's see what are our build VARs
	if [ -n "$FOX_BUILD_LOG_FILE" -a -f "$FOX_BUILD_LOG_FILE" ]; then
  	   export | grep "FOX" >> $FOX_BUILD_LOG_FILE
  	   export | grep "OF_" >> $FOX_BUILD_LOG_FILE
   	   export | grep "TARGET_" >> $FOX_BUILD_LOG_FILE
  	   export | grep "TW_" >> $FOX_BUILD_LOG_FILE
 	fi
fi
