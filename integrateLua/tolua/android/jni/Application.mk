APP_STL := gnustl_static
APP_CPPFLAGS += -frtti 
# -DCOCOS2D_DEBUG=1 -DCC_ENABLE_CHIPMUNK_INTEGRATION=1
APP_CPPFLAGS += -fexceptions
APP_CPPFLAGS += -fvisibility=hidden

LOCAL_CFLAGS += -fvisibility=hidden

APP_ABI := armeabi armeabi-v7a arm64-v8a x86
APP_CPPFLAGS += -std=c++11
APP_PLATFORM := android-14
