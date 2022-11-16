//
//  FileUtils.cpp
//  iosLuaTest
//
//  Created by qibinyi on 2/7/18.
//  Copyright © 2018 qibinyi. All rights reserved.
//

#define CC_SAFE_DELETE(p)            do { if(p) { delete (p); (p) = 0; } } while(0)
#define CC_SAFE_DELETE_ARRAY(p)     do { if(p) { delete[] (p); (p) = 0; } } while(0)
#define CC_SAFE_FREE(p)                do { if(p) { free(p); (p) = 0; } } while(0)
#define CC_SAFE_RELEASE(p)            do { if(p) { (p)->release(); } } while(0)
#define CC_SAFE_RELEASE_NULL(p)        do { if(p) { (p)->release(); (p) = 0; } } while(0)
#define CC_SAFE_RETAIN(p)            do { if(p) { (p)->retain(); } } while(0)


#include "FileUtils.h"
#include "platform_header.h"

//test
//#include "base/ccUTF8.h"
// #include "ConvertUTF.h"

using namespace std ;




FileUtils* FileUtils::s_sharedFileUtils = 0;
pthread_mutex_t FileUtils::instMutexlock ;

FileUtils::FileUtils()
{
    // init lock here
    pthread_mutex_init(&mutexlock, 0);
    pthread_mutex_init(&FileUtils::instMutexlock, 0);

}

FileUtils::~FileUtils()
{
    // deinit lock here
    pthread_mutex_destroy(&mutexlock);
    pthread_mutex_destroy(&FileUtils::instMutexlock);
}

FileUtils* FileUtils::sharedFileUtils()
{
    // lock
    pthread_mutex_lock(&FileUtils::instMutexlock);
    
    if (s_sharedFileUtils ==  0 )
    {
        s_sharedFileUtils = new FileUtils();
        //s_sharedFileUtils->init();
        
        //test
        //StringUtils::format("test");
    }
    //CCLog("FileUtils inst address: %p \n", &s_sharedFileUtils );

    // unlock
    pthread_mutex_unlock(&FileUtils::instMutexlock);

    return s_sharedFileUtils;
}

#if (CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID)
    // in FileUtilsAndroid.cpp
#else
unsigned char* FileUtils::getFileData(const char* pszFileName, const char* pszMode, unsigned long * pSize)
{
    unsigned char * pBuffer = NULL;
    //CCAssert(pszFileName != NULL && pSize != NULL && pszMode != NULL, "Invalid parameters.");
    *pSize = 0;
    do
    {
        // read the file from hardware
        std::string fullPath = pszFileName ;// fullPathForFilename(pszFileName);
        
        //*
        // TODO , only for test
        if ( fullPath[0] != '/' ) {
            fullPath = getResourcePath() + pszFileName;
        }
        //*/
        
        //CCLog( "fullPath %s\n", fullPath.c_str() );
        
        FILE *fp = fopen(fullPath.c_str(), pszMode);
        CC_BREAK_IF(!fp);
        
        fseek(fp,0,SEEK_END);
        *pSize = ftell(fp);
        fseek(fp,0,SEEK_SET);
        pBuffer = new unsigned char[*pSize];
        *pSize = fread(pBuffer,sizeof(unsigned char), *pSize,fp);
        fclose(fp);
    } while (0);
    
    if (! pBuffer)
    {
        std::string msg = "Get data from file(";
        msg.append(pszFileName).append(") failed!");
        
        CCLog("%s\n", msg.c_str());
    }
    return pBuffer;
}
#endif

