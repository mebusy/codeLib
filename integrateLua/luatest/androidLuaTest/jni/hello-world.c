#include <string.h>
#include <jni.h>

jstring
Java_com_apixel_luaTest_Main_stringFromJNI(JNIEnv* env, jobject thiz)
{
    return (*env)->NewStringUTF(env, "Hello world from JNI!");
}

