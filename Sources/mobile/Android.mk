LOCAL_PATH:= $(call my-dir)/../

include $(CLEAR_VARS)

LOCAL_MODULE := q3lite

LOCAL_CFLAGS :=

LOCAL_CPPFLAGS :=  $(LOCAL_CFLAGS)  -fpermissive


LOCAL_C_INCLUDES :=     $(SDL_INCLUDE_PATHS)  \
                        $(TOP_DIR) \
                        $(TOP_DIR)/MobileTouchControls \
                        $(TOP_DIR)/AudioLibs_OpenTouch/liboggvorbis/include \
                        $(TOP_DIR)/Clibs_OpenTouch \
                        $(TOP_DIR)/Clibs_OpenTouch/quake \
                        $(LOCAL_PATH)/jpeg-8c/ \
                        $(LOCAL_PATH)/libvorbis-1.3.5/lib



PROJECT_FILES :=

PROJECT_FILES += $(wildcard $(LOCAL_PATH)/sdl/*.c)


PROJECT_FILES := $(PROJECT_FILES:$(LOCAL_PATH)/%=%)


PROJECT_FILES +=    sys/con_log.c \
                    sys/sys_main.c \
                    sys/sys_unix.c \
                    mobile/ifaddrs.c \
                    mobile/con_android.c \
                    mobile/game_interface.c \
                    ../../../Clibs_OpenTouch/quake/android_jni.cpp \
                    ../../../Clibs_OpenTouch/quake/touch_interface.cpp \

EXCLUDE :=  qcommon/vm_x86.c \
            qcommon/vm_armv7l.c \
            qcommon/vm_sparc.c \
            qcommon/vm_none.c \
            qcommon/vm_powerpc.c \
            qcommon/vm_powerpc_asm.c \
            server/sv_rankings.c \
            client/libmumblelink.c \
            renderergles1/tr_subs.c \




PROJECT_FILES := $(filter-out $(EXCLUDE), $(PROJECT_FILES))

ifeq ($(TARGET_ARCH_ABI),arm64-v8a)
   LOCAL_CFLAGS += -DNO_VM_COMPILED
endif

ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
  PROJECT_FILES +=  qcommon/vm_armv7l.c
endif

ifeq ($(TARGET_ARCH_ABI),x86)
  PROJECT_FILES +=  qcommon/vm_x86.c
endif

LOCAL_SRC_FILES =  $(PROJECT_FILES)


LOCAL_LDLIBS := -lEGL -ldl -llog -lOpenSLES -lz -lGLESv1_CM
LOCAL_STATIC_LIBRARIES := sigc libzip libpng logwritter license_static SDL2_net
LOCAL_SHARED_LIBRARIES := touchcontrols SDL2  SDL2_mixer

include $(BUILD_SHARED_LIBRARY)
