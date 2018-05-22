/****************************************************************************
Copyright (c) 2011 cocos2d-x.org

http://www.cocos2d-x.org

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
****************************************************************************/
#include "Cocos2dxLuaLoader.h"
#include <string>
#include <algorithm>
#include "FileUtils.h"
#include "platform_header.h"

//#include "CCLuaStack.h"
//#include "CCLuaEngine.h"

//using namespace cocos2d;

extern "C"
{
    int luaLoadBuffer(lua_State* L, const char* chunk, int chunkSize, const char* chunkName)
    {
        int r = 0;
        
        {
            r = luaL_loadbuffer(L, chunk, chunkSize, chunkName);
        }
        
// #if defined(COCOS2D_DEBUG) && COCOS2D_DEBUG > 0
#if 1
        if (r)
        {
            switch (r)
            {
                case LUA_ERRSYNTAX:
                    CCLog("[LUA ERROR] load \"%s\", error: syntax error during pre-compilation.\n", chunkName);
                    break;
                    
                case LUA_ERRMEM:
                    CCLog("[LUA ERROR] load \"%s\", error: memory allocation error.\n", chunkName);
                    break;
                    
                case LUA_ERRFILE:
                    CCLog("[LUA ERROR] load \"%s\", error: cannot open/read file.\n", chunkName);
                    break;
                    
                default:
                    CCLog("[LUA ERROR] load \"%s\", error: unknown.\n", chunkName);
            }
        }
#endif
        return r;
    }

    
    int cocos2dx_lua_loader(lua_State *L)
    {
        static const std::string BYTECODE_FILE_EXT    = ".luac";
        static const std::string NOT_BYTECODE_FILE_EXT = ".lua";
        
        std::string filename(luaL_checkstring(L, 1));
        size_t pos = filename.rfind(BYTECODE_FILE_EXT);
        if (pos != std::string::npos)
        {
            filename = filename.substr(0, pos);
        }
        else
        {
            pos = filename.rfind(NOT_BYTECODE_FILE_EXT);
            if (pos == filename.length() - NOT_BYTECODE_FILE_EXT.length())
            {
                filename = filename.substr(0, pos);
            }
        }
        
        pos = filename.find_first_of(".");
        while (pos != std::string::npos)
        {
            filename.replace(pos, 1, "/");
            pos = filename.find_first_of(".");
        }
        
        //search file in package.path
        unsigned char* chunk = NULL;
        unsigned long chunkSize = 0;
        std::string chunkName = "";
        FileUtils* utils = FileUtils::sharedFileUtils();
        
        lua_getglobal(L, "package");
        lua_getfield(L, -1, "path");
        std::string searchpath(lua_tostring(L, -1));
        lua_pop(L, 1);
        size_t begin = 0;
        size_t next = searchpath.find_first_of(";", 0);
        
        int debug = 0 ;
        do
        {
            if (next == std::string::npos)
                next = searchpath.length();
            
            std::string prefix = searchpath.substr(begin, next);
            if (prefix[0] == '.' && prefix[1] == '/')
            {
                prefix = prefix.substr(2);
            }
            
            pos = prefix.find("?.lua");
            chunkName = prefix.substr(0, pos) + filename + BYTECODE_FILE_EXT;
            if (utils->isFileExist(chunkName))
            {
                debug = 10 ;
                chunk = utils->getFileData(chunkName.c_str(), "rb", &chunkSize);
                break;
            }
            else
            {
                debug = 20 ;
                chunkName = prefix.substr(0, pos) + filename + NOT_BYTECODE_FILE_EXT;
                if (utils->isFileExist(chunkName))
                {
                    debug = 30 ;
                    chunk = utils->getFileData(chunkName.c_str(), "rb", &chunkSize);
                    break;
                }
            }
            
            begin = next + 1;
            next  = searchpath.find_first_of(";", begin);
        }while ( begin < (size_t)searchpath.length());
        
        if (NULL != chunk)
        {
            luaLoadBuffer(L, (char*)chunk, (int)chunkSize, chunkName.c_str());
            free(chunk);
        }
        else
        {
            CCLog("can not get file data of %s, info:%d\n", filename.c_str() , debug );
        }
        
        return 1;
    }
}
