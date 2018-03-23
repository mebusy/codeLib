#include <jni.h>
#include <android/log.h>
#include "LuaState.h"

#include "platform_header.h"
#include "CCJniHelper.h"

extern "C" {

    void
    Java_com_apixel_luaTest_Main_nativeInit(JNIEnv* env, jobject thiz)
    {
        CCLog( "jni cpp ! "   ) ;
        LuaState::getInstance().executeString( "print ( 'executeString lua' )" )  ;
        LuaState::getInstance().executeString( "require 'entry' " )  ;
    }

    JNIEXPORT jint JNI_OnLoad(JavaVM* vm, void *reserved)
    {
        
        CCLog( "main  JNI_OnLoad ! "   ) ;
        return JNI_VERSION_1_4;
    }

}
