#include "../FileUtils.h"
#include <string>
#include "CCJniHelper.h"
#include "Java_org_cocos2dx_lib_Cocos2dxHelper.h"
#include "platform_header.h"
#include "android/asset_manager_jni.h"


using namespace std ; 

AAssetManager* FileUtils::_assetmanager = 0 ;

void FileUtils::setassetmanager(AAssetManager* a) {
    if (nullptr == a) {
        CCLog("setassetmanager : received unexpected nullptr parameter \n");
        return;
    }

    // lock
    pthread_mutex_lock(&mutexlock);
    FileUtils::_assetmanager = a;
    // unlock
    pthread_mutex_unlock(&mutexlock);

    pthread_t thisthread = pthread_self();
    CCLog("setassetmanager : set , pthread_self() = %ld", thisthread);

}

AAssetManager* FileUtils::getAssetmanager() {
    // lock
    pthread_mutex_lock(&mutexlock);
    AAssetManager* a = FileUtils::_assetmanager ;
    // unlock
    pthread_mutex_unlock(&mutexlock);

    return a ;
}

std::string FileUtils::getResourcePath() {
    std::string resourcePath = getApkPath();

    return resourcePath + "/" + "assets/" ;    
}
std::string FileUtils::getWritablePath() {
    string dir("");
    string tmp = getFileDirectoryJNI();

    if (tmp.length() > 0)
    {
        dir.append(tmp).append("/");

        return dir;
    }
    else
    {
        return "";
    }
}


bool FileUtils::isFileExist(const std::string& strFilePath) {
    // return isFileExistsJNI( strFilePath.c_str() ) ;
    if (strFilePath.empty())
    {
        return false;
    }

    //pthread_t thisthread = pthread_self();
    //CCLog("FileUtils::isFileExist : pthread_self() = %ld", thisthread);
    
    bool bFound = false;
    int debug = 0 ;
    
    // Check whether file exists in apk.
    if (strFilePath[0] != '/')
    {
        debug = 10 ;  //CCLog( "isFileExist  debug: %d \n" , debug);
        const char* s = strFilePath.c_str();
        
        // Found "assets/" at the beginning of the path and we don't want it
        if (strFilePath.find("assets/") == 0) s += strlen("assets/");
        
        if (getAssetmanager()) {
            debug = 20 ;  //CCLog( "isFileExist  debug: %d \n" , debug);
            AAsset* aa = AAssetManager_open(getAssetmanager(), s, AASSET_MODE_UNKNOWN);
            if (aa)
            {
                debug = 30 ; //CCLog( "isFileExist  debug: %d \n" , debug); 
                bFound = true;
                AAsset_close(aa);
            } else {
                debug = 40 ; //CCLog( "isFileExist  debug: %d \n" , debug);
                // CCLOG("[AssetManager] ... in APK %s, found = false!", strFilePath.c_str());
            }
        }
    }
    else
    {
        debug = 50 ;  //CCLog( "isFileExist  debug: %d \n" , debug);

        FILE *fp = fopen(strFilePath.c_str(), "r");
        if(fp)
        {
            debug = 60 ; //CCLog( "isFileExist  debug: %d \n" , debug);
            bFound = true;
            fclose(fp);
        }

    }
    //CCLog( "isFileExist %s : %d , info: %d \n" , strFilePath.c_str(), bFound , debug  );
    return bFound;
}

unsigned char* FileUtils::getFileData(const char* pszFileName, const char* mode, unsigned long * size)
{
    if (pszFileName ==0)
        return 0 ;
    
    std::string filename(pszFileName) ;
    
    unsigned char * data = 0;
    
    if ( filename.empty() || (! mode) )
    {
        return 0;
    }
    
    string fullPath = filename ; //fullPathForFilename(filename);
    
    if (fullPath[0] != '/')
    {
        string relativePath = string();
        
        size_t position = fullPath.find("assets/");
        if (0 == position) {
            // "assets/" is at the beginning of the path and we don't want it
            relativePath += fullPath.substr(strlen("assets/"));
        } else {
            relativePath += fullPath;
        }
        // CCLog("relative path = %s\n", relativePath.c_str());
        
        if (nullptr == getAssetmanager()) {
            CCLog("... getAssetmanager() is nullptr\n");
            return nullptr;
        }
        
        // read asset data
        AAsset* asset =
        AAssetManager_open(getAssetmanager(),
                           relativePath.c_str(),
                           AASSET_MODE_UNKNOWN);
        if (nullptr == asset) {
            CCLog("asset is nullptr\n");
            return nullptr;
        }
        
        off_t fileSize = AAsset_getLength(asset);
        
        data = (unsigned char*) malloc(fileSize);
        
        int bytesread = AAsset_read(asset, (void*)data, fileSize);
        if (size)
        {
            *size = bytesread;
        }
        
        AAsset_close(asset);
    }
    else
    {
        do
        {
            // read rrom other path than user set it
            //CCLOG("GETTING FILE ABSOLUTE DATA: %s", filename);
            FILE *fp = fopen(fullPath.c_str(), mode);
            CC_BREAK_IF(!fp);
            
            long fileSize;
            fseek(fp,0,SEEK_END);
            fileSize = ftell(fp);
            fseek(fp,0,SEEK_SET);
            data = (unsigned char*) malloc(fileSize);
            fileSize = fread(data,sizeof(unsigned char), fileSize,fp);
            fclose(fp);
            
            if (size)
            {
                *size = fileSize;
            }
        } while (0);
    }
    
    if (! data)
    {
        std::string msg = "Get data from file(";
        msg.append(filename).append(") failed!");
        CCLog("%s\n", msg.c_str());
    }
    
    return data;
}
