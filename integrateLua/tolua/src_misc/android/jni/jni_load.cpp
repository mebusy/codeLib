
#include <jni.h>
#include <android/log.h>

#include "platform_header.h"
#include "CCJniHelper.h"

extern "C" {
    JNIEXPORT jint JNI_OnLoad(JavaVM* vm, void *reserved)
    {
        CCLog( "tolua JNI_OnLoad  ! "   ) ;

        CCJniHelper::setJavaVM(vm);

        return JNI_VERSION_1_4;
    }
}
