//
//  FileUtils.h
//  iosLuaTest
//
//  Created by qibinyi on 2/7/18.
//  Copyright © 2018 qibinyi. All rights reserved.
//

#ifndef FileUtils_h
#define FileUtils_h
#include <string>
#define CC_BREAK_IF(cond)            if(cond) break

#include "platform_header.h"

#if (CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID)
#include <android/asset_manager.h>
#endif



class FileUtils
{
public:
    static FileUtils* sharedFileUtils();
    virtual ~FileUtils();

    // endswith "/"
    virtual std::string getResourcePath() ;
    // endswith "/"
    virtual std::string getWritablePath() ;
    bool isFileExist(const std::string& strFilePath) ;
    
    // if you call getFileData , you must release the memory allocated !!!
    unsigned char* getFileData(const char* pszFileName, const char* pszMode, unsigned long * pSize);
protected:
    static FileUtils* s_sharedFileUtils;

#if (CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID)
public:
    static void  setassetmanager(AAssetManager* a) ;
private:
    static AAssetManager* assetmanager  ;
#endif

} ;

#endif /* FileUtils_h */
