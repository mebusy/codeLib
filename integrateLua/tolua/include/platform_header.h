#ifndef PLATFORM_HEADER_H
#define PLATFORM_HEADER_H

#include "stdio.h"

#include "CCPlatformConfig.h"


#if (CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID)
    // for log : LOCAL_LDLIBS := -llog
    #include <android/log.h> 
    #define  CCLog(...)  __android_log_print(ANDROID_LOG_DEBUG,"MAIN",__VA_ARGS__)
#else
    #define  CCLog(...) printf( __VA_ARGS__ ) 
#endif

/*
 * only certain compilers support __attribute__((deprecated))
 */
#if defined(__GNUC__) && ((__GNUC__ >= 4) || ((__GNUC__ == 3) && (__GNUC_MINOR__ >= 1)))
#define CC_DEPRECATED_ATTRIBUTE __attribute__((deprecated))
#elif _MSC_VER >= 1400 //vs 2005 or higher
#define CC_DEPRECATED_ATTRIBUTE __declspec(deprecated)
#else
#define CC_DEPRECATED_ATTRIBUTE
#endif

/*
 * only certain compiler support __attribute__((format))
 * formatPos - 1-based position of format string argument
 * argPos - 1-based position of first format-dependent argument
 */
#if defined(__GNUC__) && (__GNUC__ >= 4)
#define CC_FORMAT_PRINTF(formatPos, argPos) __attribute__((__format__(printf, formatPos, argPos)))
#elif defined(__has_attribute)
#if __has_attribute(format)
#define CC_FORMAT_PRINTF(formatPos, argPos) __attribute__((__format__(printf, formatPos, argPos)))
#endif // __has_attribute(format)
#else
#define CC_FORMAT_PRINTF(formatPos, argPos)
#endif

#if defined(_MSC_VER)
#define CC_FORMAT_PRINTF_SIZE_T "%08lX"
#else
#define CC_FORMAT_PRINTF_SIZE_T "%08zX"
#endif


#endif


