LOCAL_PATH := $(call my-dir)

# declar a prebuilt library
include $(CLEAR_VARS)
LOCAL_MODULE := luajit
# $(warning $(LOCAL_PATH))   #  jni
# PS: LOCAL_SRC_FILES should be a relative path
LOCAL_SRC_FILES := ../../../luajit/prebuilt/android/$(TARGET_ARCH_ABI)/libluajit.a
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/../../../luajit/include
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := curl
# $(warning $(LOCAL_PATH))   #  jni
# PS: LOCAL_SRC_FILES should be a relative path
LOCAL_SRC_FILES := ../../../curl/prebuilt/android/$(TARGET_ARCH_ABI)/libcurl.a
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/../../../curl/include/android
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := openssl
# $(warning $(LOCAL_PATH))   #  jni
# PS: LOCAL_SRC_FILES should be a relative path
LOCAL_SRC_FILES := ../../../openssl/prebuilt/android/$(TARGET_ARCH_ABI)/libssl.a
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/../../../openssl/include/android
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := crypto
# $(warning $(LOCAL_PATH))   #  jni
# PS: LOCAL_SRC_FILES should be a relative path
LOCAL_SRC_FILES := ../../../openssl/prebuilt/android/$(TARGET_ARCH_ABI)/libcrypto.a
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/../../../openssl/include/android
include $(PREBUILT_STATIC_LIBRARY)


include $(CLEAR_VARS)
# LOCAL_FORCE_STATIC_EXECUTABLE := true
LOCAL_MODULE := tolua
LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../include
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../src_misc
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../../luabinding/luabinding
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../../lua_3rd_lib/luasocket-2.0.2/src
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../../lua_3rd_lib/md5-1.1.2/src
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../../lua_3rd_lib/lua-curl/src


# LOCAL_CPPFLAGS := -O2
# LOCAL_CFLAGS :=  -O2  
# -std=gnu99
LUASOCKETS := $(wildcard $(LOCAL_PATH)/../../../lua_3rd_lib/luasocket-2.0.2/src/*.c)
MD5S := $(wildcard $(LOCAL_PATH)/../../../lua_3rd_lib/md5-1.1.2/src/*.c)
LUACURLS := $(wildcard $(LOCAL_PATH)/../../../lua_3rd_lib/lua-curl/src/*.c)

LOCAL_SRC_FILES :=		../../src/tolua_event.c	\
						../../src/tolua_fix.c	\
						../../src/tolua_is.c	\
						../../src/tolua_map.c	\
						../../src/tolua_push.c	\
						../../src/tolua_to.c \
						../../src_misc/FileUtils.cpp \
						../../src_misc/AppUtils.cpp \
						../../src_misc/Cocos2dxLuaLoader.cpp \
						../../src_misc/base/ccUTF8.cpp \
						../../src_misc/ConvertUTF/ConvertUTF.c \
						../../src_misc/android/FileUtilsAndroid.cpp \
						../../src_misc/android/CCLuaJavaBridge.cpp \
						../../src_misc/android/jni/CCJniHelper.cpp  \
						../../src_misc/android/jni/Java_org_cocos2dx_lib_Cocos2dxHelper.cpp  \
						../../src_misc/android/jni/Java_org_cocos2dx_lib_Cocos2dxLuaJavaBridge.cpp  \
						../../src_misc/android/jni/jni_load.cpp  \
 						../../../luabinding/luabinding/luabinding.cpp \
 						../../../lua_3rd_lib/cLua/lualoadexts.c 



LOCAL_SRC_FILES += $(LUASOCKETS:$(LOCAL_PATH)/%=%) 
LOCAL_SRC_FILES += $(MD5S:$(LOCAL_PATH)/%=%) 
LOCAL_SRC_FILES += $(LUACURLS:$(LOCAL_PATH)/%=%) 

# Referencing the Prebuilt Library
LOCAL_STATIC_LIBRARIES := luajit
LOCAL_STATIC_LIBRARIES += curl
LOCAL_STATIC_LIBRARIES += openssl
LOCAL_STATIC_LIBRARIES += crypto


# other lib
LOCAL_LDLIBS := -landroid -llog -lz

include $(BUILD_STATIC_LIBRARY)
