//
//  AppUtils.h
//  iosLuaTest
//
//  Created by qibinyi on 2/7/18.
//  Copyright © 2018 qibinyi. All rights reserved.
//

#ifndef AppUtils_h
#define AppUtils_h


namespace PLATFORM {
    enum   {
        OS_UNKNOWN           =0,
        OS_IOS                ,
        OS_ANDROID            ,
        OS_WIN32              ,
        OS_MARMALADE          ,
        OS_LINUX              ,
        OS_BADA               ,
        OS_BLACKBERRY         ,
        OS_MAC                ,
        OS_NACL               ,
        OS_EMSCRIPTEN        ,
        OS_TIZEN             ,
        OS_QT5               ,
        OS_WINRT             ,
    }  ;
}

class AppUtils
{
public:
    static AppUtils& getInstance()  {
        static AppUtils theSingleton;
        return theSingleton;
    }
    
    int getTargetPlatform() ;
    
private:
    AppUtils() // 必须定义, 且为private.
    {  }
    AppUtils(const AppUtils&);            // 不实现.
    
    AppUtils& operator=(const AppUtils&); // 不实现.
    
    virtual ~AppUtils() // 可声明为public, 但这里声明为private没有错, 可被调用.
    {  }
} ;

#endif /* AppUtils_h */
