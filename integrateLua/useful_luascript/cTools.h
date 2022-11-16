//
//  cTools.h
//  nba_heroes
//
//  Created by qibinyi on 5/19/14.
//
//

#ifndef __nba_heroes__cTools__
#define __nba_heroes__cTools__

#if (CC_TARGET_PLATFORM != CC_PLATFORM_WIN32)
#include <sys/time.h>
#endif

#include "cocos2d.h"
#include <stdio.h>

#include <zlib.h>

#if (CC_TARGET_PLATFORM != CC_PLATFORM_WIN32) && (CC_TARGET_PLATFORM != CC_PLATFORM_WP8) && (CC_TARGET_PLATFORM != CC_PLATFORM_WINRT)
#include <sys/types.h>
#include <sys/stat.h>
#include <errno.h>
#include <dirent.h>
#endif


#if (CC_TARGET_PLATFORM == CC_PLATFORM_WIN32)
static int gettimeofday(struct timeval * val, struct timezone *)
{
	if (val)
	{
		SYSTEMTIME wtm;
		GetLocalTime(&wtm);

		struct tm tTm;
		tTm.tm_year     = wtm.wYear - 1900;
		tTm.tm_mon      = wtm.wMonth - 1;
		tTm.tm_mday     = wtm.wDay;
		tTm.tm_hour     = wtm.wHour;
		tTm.tm_min      = wtm.wMinute;
		tTm.tm_sec      = wtm.wSecond;
		tTm.tm_isdst    = -1;

		val->tv_sec     = (long)mktime(&tTm);       // time_t is 64-bit on win32
		val->tv_usec    = wtm.wMilliseconds * 1000;
	}
	return 0;
}
#endif

//USING_NS_CC;

class cTools
{
public:
    static cTools& instance()
    {
        static cTools theSingleton;
        return theSingleton;
    }
    
    // b64Ret: 是否返回 base64编码!
    static std::string decodeData( std::string file_name , bool b64Ret=false ) {
        
        cocos2d::Data data = cocos2d::FileUtils::getInstance()->getDataFromFile( file_name );
        int size = data.getSize() ;
        unsigned char* chardata = (unsigned char* )data.getBytes() ;
        
        
        for (int i=0; i< size ; i+=2) {
            chardata[i]^= ((i+39)&0xFF ) ;
            
            if ( i+1>=size ) {
                break;
            }
            chardata[i+1] ^=  chardata[i] ;
        }
        
        if (b64Ret ) {
            char *encodedData = 0;
            
            cocos2d::base64Encode((const unsigned char*)chardata, size , &encodedData) ;
            
            std::string res( encodedData  ) ;
            
            free( encodedData ) ;
            
            return res ;
            
        }
        else  {
            std::string res ( (char*)chardata) ;
            
            return res ;
        }
        
        return NULL;
    }
    
    
    // b64Ret: 是否返回 base64编码!
    static std::string getBase64File( std::string file_name  ) {
        
        cocos2d::Data data = cocos2d::FileUtils::getInstance()->getDataFromFile( file_name );
        int size = data.getSize() ;
        unsigned char* chardata = (unsigned char* )data.getBytes() ;
        
        

        char *encodedData = 0;
        
        cocos2d::base64Encode((const unsigned char*)chardata, size , &encodedData) ;
        
        std::string res( encodedData  ) ;
        
        free( encodedData ) ;
        
        return res ;
            

    }
    
    
    
    static long long getCurrentUSecond() {
        long lLastTime;
        struct timeval stCurrentTime;
        
        gettimeofday(&stCurrentTime,NULL);
        lLastTime = stCurrentTime.tv_sec*1000*1000+stCurrentTime.tv_usec ; //millseconds
        return lLastTime;
    }
    
    static long long getCurrentMillSecond() {
        long lLastTime;
        struct timeval stCurrentTime;
        
        gettimeofday(&stCurrentTime,NULL);
        lLastTime = stCurrentTime.tv_sec*1000+stCurrentTime.tv_usec*0.001; //millseconds
        return lLastTime;
    }
    
    
    static bool runningIsTransition() {
        cocos2d::Scene* _runningScene = cocos2d::Director::getInstance()->getRunningScene();
        cocos2d::Scene* _nextScene = cocos2d::Director::getInstance()->getNextScene();
        
        bool runningIsTransition = dynamic_cast<cocos2d::TransitionScene*>(_runningScene) != nullptr;
        bool newIsTransition = dynamic_cast<cocos2d::TransitionScene*>(_nextScene) != nullptr;
        
        
        runningIsTransition = runningIsTransition || newIsTransition ;
        return runningIsTransition ;
    }
    
    static void myPrint( const char* str ) {
        printf( "%s\n" , str ) ;
    }
    
    
    static void showTimeConsume( const std::string& info ) {
#if COCOS2D_DEBUG == 1
        static long long tick_ = getCurrentUSecond();
        
        CCLOG( "%s used time: %lld" , info.c_str() ,  getCurrentUSecond() - tick_ ) ;
        tick_ = getCurrentUSecond();
#endif
    }
    
    static bool isLoginInner() {
#ifdef LOGIN_INNER
        return true;
#else
        return false;
#endif
    
    }
    
    static bool isPubAdminVersion() {
#ifdef PUB_ADMIN
        return true;
#else
        return false;
#endif
        
    }
    
    static bool isDebugVersion() {
#if COCOS2D_DEBUG == 1
#ifdef WIN_DEBUG_RELEASE
		return false;
#endif
        return true;
#else
        return false;
#endif
        
    }
    
    
    static std::string zip_inflat( const std::string& bufB64 ) {
        
        unsigned char * decodedData = nullptr;
        int decodedDataLen = cocos2d::base64Decode((unsigned char*)bufB64.c_str(), (unsigned int)static_cast<int>(bufB64.size()), &decodedData);
        
        /*
        std::string buf ;
        buf.append( (const char *)decodedData, decodedDataLen);

        free( decodedData );
        decodedData = nullptr;
        //*/
        
        //*
        int dataLen = decodedDataLen ;
        const unsigned char * data = decodedData ;
        
        unsigned char* unpackedData = nullptr;
        ssize_t unpackedLen = 0;
        
        unpackedLen = cocos2d::ZipUtils::inflateMemory(const_cast<unsigned char*>(data), dataLen, &unpackedData);

        //*/
        
        std::string buf ;
        buf.append( (const char *)unpackedData, unpackedLen);
        
        //释放!
        free( decodedData );
        decodedData = nullptr;
        free(unpackedData);
        decodedData = nullptr;
        
        return buf ;
    }
    
    
    static std::string zip_deflat( const std::string& buf ) {
        
        unsigned long buf_size= (unsigned long)static_cast<int>(buf.size()) ;
        
        static const int len = 256*1024 ;
        unsigned long len_tmp = len;
        
        static unsigned char buffer_tmp[len];
        memset( buffer_tmp , 0 ,  len );
        
        int result = compress(buffer_tmp, &len_tmp,  (const unsigned char *)buf.c_str() , buf_size );
        
        //compress( buffer_tmp, &len_tmp , NULL , 0 );
        
        char *encodedData = 0;
        
        cocos2d::base64Encode((const unsigned char*)buffer_tmp, len_tmp , &encodedData) ;
        
        std::string res( encodedData  ) ;
        
        free( encodedData ) ;
        
        return res ;
        
    }
    
    //获取客户端 基本版本号，用于资源下载
    static std::string getClientBaseVersion() {
#if CC_TARGET_PLATFORM == CC_PLATFORM_IOS
        return "2_0_0";
#else
        return "1_0_0";
#endif
    }
    
    
    
    // ios 不要调用!
    static void createFolder_android( std::string  _storagePath ) {
        // Remove downloaded files
#if (CC_TARGET_PLATFORM != CC_PLATFORM_WIN32)
        DIR *dir = NULL;
        
        dir = opendir (_storagePath.c_str());
        if (!dir)
        {
            mkdir(_storagePath.c_str(), S_IRWXU | S_IRWXG | S_IRWXO);
        }
#else
        if ((GetFileAttributesA(_storagePath.c_str())) == INVALID_FILE_ATTRIBUTES)
        {
            CreateDirectoryA(_storagePath.c_str(), 0);
        }
#endif
    }
    
    static void exitGame_android() {
        exit(0);
    }
    
    // ios 不要调用!
    static bool canAccessPasteboard_android( ) {
        return true ;
    }
    
    
private:
    cTools() // 必须定义, 且为private.
    {
        
    }
    
    cTools(const cTools&);            // 不实现.
    
    cTools& operator=(const cTools&); // 不实现.
    
    ~cTools() // 可声明为public, 但这里声明为private没有错, 可被调用.
    {
        
    }
};

#endif /* defined(__nba_heroes__cTools__) */
