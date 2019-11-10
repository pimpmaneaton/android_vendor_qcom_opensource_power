# Copyright (c) 2012-2019, The Linux Foundation. All rights reserved.
# Copyright (C) 2017-2019 The LineageOS Project
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
# *    * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above
#       copyright notice, this list of conditions and the following
#       disclaimer in the documentation and/or other materials provided
#       with the distribution.
#     * Neither the name of The Linux Foundation nor the names of its
#       contributors may be used to endorse or promote products derived
#       from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT
# ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
# OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
# IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

LOCAL_PATH := $(call my-dir)

ifeq ($(call is-vendor-board-platform,QCOM),true)

include $(CLEAR_VARS)

LOCAL_MODULE_RELATIVE_PATH := hw

LOCAL_SHARED_LIBRARIES := \
    liblog \
    libcutils \
    libdl \
    libbase \
    libhidlbase \
    libhidltransport \
    libhwbinder \
    libutils \
    android.hardware.power@1.2 \
    vendor.lineage.power@1.0

LOCAL_HEADER_LIBRARIES := \
    libhardware_headers

LOCAL_SRC_FILES := \
    power-common.c \
    metadata-parser.c \
    utils.c \
    list.c \
    hint-data.c \
    service.cpp \
    Power.cpp

LOCAL_CFLAGS += -Wall -Wextra -Werror

ifneq ($(TARGET_USES_NON_LEGACY_POWERHAL), true)
LOCAL_SHARED_LIBRARIES := \
    liblog \
    libcutils \
    libdl \
    libxml2

LOCAL_SRC_FILES := \
    power.c \
    metadata-parser.c \
    utils.c \
    list.c \
    hint-data.c \
    powerhintparser.c

endif

ifneq ($(BOARD_POWER_CUSTOM_BOARD_LIB),)
    LOCAL_WHOLE_STATIC_LIBRARIES += $(BOARD_POWER_CUSTOM_BOARD_LIB)
else

# Include target-specific files.
ifeq ($(call is-board-platform-in-list,msm8960), true)
LOCAL_SRC_FILES += power-8960.c
endif

ifeq ($(call is-board-platform-in-list,msm8974), true)
LOCAL_SRC_FILES += power-8974.c
endif

ifeq ($(call is-board-platform-in-list,msm8226), true)
LOCAL_SRC_FILES += power-8226.c
endif

ifeq ($(call is-board-platform-in-list,msm8610), true)
LOCAL_SRC_FILES += power-8610.c
endif

ifeq ($(call is-board-platform-in-list,apq8084), true)
LOCAL_SRC_FILES += power-8084.c
endif

ifeq ($(call is-board-platform-in-list,msm8909), true)
LOCAL_SRC_FILES += power-8909.c
endif

ifeq ($(call is-board-platform-in-list,msm8916), true)
LOCAL_SRC_FILES += power-8916.c
endif

ifeq ($(call is-board-platform-in-list,msm8992), true)
LOCAL_SRC_FILES += power-8992.c
endif

ifeq ($(call is-board-platform-in-list,msm8994), true)
LOCAL_SRC_FILES += power-8994.c
endif

ifeq ($(call is-board-platform-in-list,msm8996), true)
LOCAL_SRC_FILES += power-8996.c
endif

ifeq ($(call is-board-platform-in-list,msm8937), true)
LOCAL_SRC_FILES += power-8937.c
endif

ifeq ($(call is-board-platform-in-list,msm8952), true)
LOCAL_SRC_FILES += power-8952.c
endif

ifeq ($(call is-board-platform-in-list,msm8953), true)
LOCAL_SRC_FILES += power-8953.c
endif

ifeq ($(call is-board-platform-in-list,msm8998 apq8098_latv), true)
LOCAL_SRC_FILES += power-8998.c
endif

ifeq ($(call is-board-platform-in-list,sdm660), true)
LOCAL_SRC_FILES += power-660.c
endif

ifeq ($(call is-board-platform-in-list,sdm845), true)
LOCAL_SRC_FILES += power-845.c
endif

ifeq ($(call is-board-platform-in-list,sdm710), true)
LOCAL_SRC_FILES += power-710.c
endif

ifeq ($(call is-board-platform-in-list,qcs605), true)
LOCAL_SRC_FILES += power-710.c
endif

ifeq ($(call is-board-platform-in-list,trinket), true)
LOCAL_SRC_FILES += power-6125.c
endif

ifeq ($(call is-board-platform-in-list,msmnile), true)
LOCAL_SRC_FILES += power-msmnile.c
endif

endif # End of board specific list

ifneq ($(TARGET_POWER_SET_FEATURE_LIB),)
    LOCAL_STATIC_LIBRARIES += $(TARGET_POWER_SET_FEATURE_LIB)
endif

ifneq ($(TARGET_POWERHAL_SET_INTERACTIVE_EXT),)
    LOCAL_CFLAGS += -DSET_INTERACTIVE_EXT
    LOCAL_SRC_FILES += ../../../../$(TARGET_POWERHAL_SET_INTERACTIVE_EXT)
endif

ifeq ($(TARGET_USES_INTERACTION_BOOST),true)
    LOCAL_CFLAGS += -DINTERACTION_BOOST
endif

ifeq ($(TARGET_ARCH),arm)
    LOCAL_CFLAGS += -DARCH_ARM_32
endif

ifneq ($(TARGET_GESTURES_NODE),)
    LOCAL_CFLAGS += -DGESTURES_NODE=\"$(TARGET_GESTURES_NODE)\"
endif

ifneq ($(TARGET_TAP_TO_WAKE_NODE),)
    LOCAL_CFLAGS += -DTAP_TO_WAKE_NODE=\"$(TARGET_TAP_TO_WAKE_NODE)\"
endif

ifneq ($(TARGET_DRAW_V_NODE),)
    LOCAL_CFLAGS += -DDRAW_V_NODE=\"$(TARGET_DRAW_V_NODE)\"
endif

ifneq ($(TARGET_DRAW_INVERSE_V_NODE),)
    LOCAL_CFLAGS += -DDRAW_INVERSE_V_NODE=\"$(TARGET_DRAW_INVERSE_V_NODE)\"
endif

ifneq ($(TARGET_DRAW_O_NODE),)
    LOCAL_CFLAGS += -DDRAW_O_NODE=\"$(TARGET_DRAW_O_NODE)\"
endif

ifneq ($(TARGET_DRAW_M_NODE),)
    LOCAL_CFLAGS += -DDRAW_M_NODE=\"$(TARGET_DRAW_M_NODE)\"
endif

ifneq ($(TARGET_DRAW_W_NODE),)
    LOCAL_CFLAGS += -DDRAW_W_NODE=\"$(TARGET_DRAW_W_NODE)\"
endif

ifneq ($(TARGET_DRAW_S_NODE),)
    LOCAL_CFLAGS += -DDRAW_S_NODE=\"$(TARGET_DRAW_S_NODE)\"
endif


ifneq ($(TARGET_DRAW_ARROW_LEFT_NODE),)
    LOCAL_CFLAGS += -DDRAW_ARROW_LEFT_NODE=\"$(TARGET_DRAW_ARROW_LEFT_NODE)\"
endif

ifneq ($(TARGET_DRAW_ARROW_RIGHT_NODE),)
    LOCAL_CFLAGS += -DDRAW_ARROW_RIGHT_NODE=\"$(TARGET_DRAW_ARROW_RIGHT_NODE)\"
endif

ifneq ($(TARGET_ONE_FINGER_SWIPE_DOWN_NODE),)
    LOCAL_CFLAGS += -DONE_FINGER_SWIPE_DOWN_NODE=\"$(TARGET_ONE_FINGER_SWIPE_DOWN_NODE)\"
endif

ifneq ($(TARGET_ONE_FINGER_SWIPE_LEFT_NODE),)
    LOCAL_CFLAGS += -DONE_FINGER_SWIPE_LEFT_NODE=\"$(TARGET_ONE_FINGER_SWIPE_LEFT_NODE)\"
endif

ifneq ($(TARGET_TWO_FINGER_SWIPE_NODE),)
    LOCAL_CFLAGS += -DTWO_FINGER_SWIPE_NODE=\"$(TARGET_TWO_FINGER_SWIPE_NODE)\"
endif

ifeq ($(TARGET_POWER_SET_FEATURE_LIB),)
  ifeq ($(TARGET_POWER_GESTURE_FILE),)
    LOCAL_SRC_FILES += power-feature-default.c
  else
    LOCAL_SRC_FILES += ../../../../$(TARGET_POWER_GESTURE_FILE)
  endif
else
  LOCAL_STATIC_LIBRARIES += $(TARGET_POWER_SET_FEATURE_LIB)
endif

ifneq ($(TARGET_USES_NON_LEGACY_POWERHAL), true)
LOCAL_MODULE := power.qcom
LOCAL_MODULE_TAGS := optional
LOCAL_CFLAGS += -DLEGACY_QCOM_POWERHAL
LOCAL_VENDOR_MODULE := true
include $(BUILD_SHARED_LIBRARY)
else
LOCAL_MODULE := android.hardware.power@1.2-service-qti
LOCAL_INIT_RC := android.hardware.power@1.2-service-qti.rc
LOCAL_MODULE_TAGS := optional
LOCAL_VENDOR_MODULE := true

include $(BUILD_EXECUTABLE)
endif

endif
