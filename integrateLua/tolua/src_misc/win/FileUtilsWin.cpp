#include "CCPlatformConfig.h"
#include "../FileUtils.h"
#include "platform_header.h"

using namespace std ;

std::string FileUtils::getResourcePath() {
    return ".";
}


std::string FileUtils::getWritablePath()
{
    return "." ;
}

bool FileUtils::isFileExist(const std::string& strFilePath) {
	// to prevent warning
	return strFilePath == "." ;
}