/*
** Lua binding: luabinding
** Generated automatically by tolua++-1.0.92 on Wed Feb 14 14:24:31 2018.
*/

#ifndef __cplusplus
#include "stdlib.h"
#endif
#include "string.h"

#include "tolua++.h"

/* Exported function */
TOLUA_API int  tolua_luabinding_open (lua_State* tolua_S);

#include "tolua_fix.h"
#include "FileUtils.h"
#include "AppUtils.h"

/* function to register type */
static void tolua_luabinding_reg_types (lua_State* tolua_S)
{
 tolua_usertype(tolua_S,"AppUtils");
 tolua_usertype(tolua_S,"FileUtils");
}

/* method: sharedFileUtils of class  FileUtils */
#ifndef TOLUA_DISABLE_tolua_luabinding_FileUtils_sharedFileUtils00
static int tolua_luabinding_FileUtils_sharedFileUtils00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"FileUtils",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  {
   FileUtils* tolua_ret = (FileUtils*)  FileUtils::sharedFileUtils();
    tolua_pushusertype(tolua_S,(void*)tolua_ret,"FileUtils");
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'sharedFileUtils'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: getResourcePath of class  FileUtils */
#ifndef TOLUA_DISABLE_tolua_luabinding_FileUtils_getResourcePath00
static int tolua_luabinding_FileUtils_getResourcePath00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"FileUtils",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  FileUtils* self = (FileUtils*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'getResourcePath'", NULL);
#endif
  {
   std::string tolua_ret = (std::string)  self->getResourcePath();
   tolua_pushcppstring(tolua_S,(const char*)tolua_ret);
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'getResourcePath'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: getWritablePath of class  FileUtils */
#ifndef TOLUA_DISABLE_tolua_luabinding_FileUtils_getWritablePath00
static int tolua_luabinding_FileUtils_getWritablePath00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"FileUtils",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  FileUtils* self = (FileUtils*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'getWritablePath'", NULL);
#endif
  {
   std::string tolua_ret = (std::string)  self->getWritablePath();
   tolua_pushcppstring(tolua_S,(const char*)tolua_ret);
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'getWritablePath'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: isFileExist of class  FileUtils */
#ifndef TOLUA_DISABLE_tolua_luabinding_FileUtils_isFileExist00
static int tolua_luabinding_FileUtils_isFileExist00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"FileUtils",0,&tolua_err) ||
     !tolua_iscppstring(tolua_S,2,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,3,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  FileUtils* self = (FileUtils*)  tolua_tousertype(tolua_S,1,0);
  const std::string strFilePath = ((const std::string)  tolua_tocppstring(tolua_S,2,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'isFileExist'", NULL);
#endif
  {
   bool tolua_ret = (bool)  self->isFileExist(strFilePath);
   tolua_pushboolean(tolua_S,(bool)tolua_ret);
   tolua_pushcppstring(tolua_S,(const char*)strFilePath);
  }
 }
 return 2;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'isFileExist'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: getFileData of class  FileUtils */
#ifndef TOLUA_DISABLE_tolua_luabinding_FileUtils_getFileData00
static int tolua_luabinding_FileUtils_getFileData00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"FileUtils",0,&tolua_err) ||
     !tolua_isstring(tolua_S,2,0,&tolua_err) ||
     !tolua_isstring(tolua_S,3,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,4,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,5,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  FileUtils* self = (FileUtils*)  tolua_tousertype(tolua_S,1,0);
  const char* pszFileName = ((const char*)  tolua_tostring(tolua_S,2,0));
  const char* pszMode = ((const char*)  tolua_tostring(tolua_S,3,0));
  unsigned long pSize = ((unsigned long)  tolua_tonumber(tolua_S,4,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'getFileData'", NULL);
#endif
  {
   unsigned char* tolua_ret = (unsigned char*)  self->getFileData(pszFileName,pszMode,&pSize);
   tolua_pushstring(tolua_S,(const char*)tolua_ret);
   tolua_pushnumber(tolua_S,(lua_Number)pSize);
  }
 }
 return 2;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'getFileData'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: getInstance of class  AppUtils */
#ifndef TOLUA_DISABLE_tolua_luabinding_AppUtils_getInstance00
static int tolua_luabinding_AppUtils_getInstance00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"AppUtils",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  {
   AppUtils& tolua_ret = (AppUtils&)  AppUtils::getInstance();
    tolua_pushusertype(tolua_S,(void*)&tolua_ret,"AppUtils");
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'getInstance'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: getTargetPlatform of class  AppUtils */
#ifndef TOLUA_DISABLE_tolua_luabinding_AppUtils_getTargetPlatform00
static int tolua_luabinding_AppUtils_getTargetPlatform00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"AppUtils",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  AppUtils* self = (AppUtils*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'getTargetPlatform'", NULL);
#endif
  {
   int tolua_ret = (int)  self->getTargetPlatform();
   tolua_pushnumber(tolua_S,(lua_Number)tolua_ret);
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'getTargetPlatform'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* Open function */
TOLUA_API int tolua_luabinding_open (lua_State* tolua_S)
{
 tolua_open(tolua_S);
 tolua_luabinding_reg_types(tolua_S);
 tolua_module(tolua_S,NULL,0);
 tolua_beginmodule(tolua_S,NULL);
  tolua_cclass(tolua_S,"FileUtils","FileUtils","",NULL);
  tolua_beginmodule(tolua_S,"FileUtils");
   tolua_function(tolua_S,"sharedFileUtils",tolua_luabinding_FileUtils_sharedFileUtils00);
   tolua_function(tolua_S,"getResourcePath",tolua_luabinding_FileUtils_getResourcePath00);
   tolua_function(tolua_S,"getWritablePath",tolua_luabinding_FileUtils_getWritablePath00);
   tolua_function(tolua_S,"isFileExist",tolua_luabinding_FileUtils_isFileExist00);
   tolua_function(tolua_S,"getFileData",tolua_luabinding_FileUtils_getFileData00);
  tolua_endmodule(tolua_S);
  tolua_module(tolua_S,"PLATFORM",0);
  tolua_beginmodule(tolua_S,"PLATFORM");
   tolua_constant(tolua_S,"OS_UNKNOWN",PLATFORM::OS_UNKNOWN);
   tolua_constant(tolua_S,"OS_IOS",PLATFORM::OS_IOS);
   tolua_constant(tolua_S,"OS_ANDROID",PLATFORM::OS_ANDROID);
   tolua_constant(tolua_S,"OS_WIN32",PLATFORM::OS_WIN32);
   tolua_constant(tolua_S,"OS_MARMALADE",PLATFORM::OS_MARMALADE);
   tolua_constant(tolua_S,"OS_LINUX",PLATFORM::OS_LINUX);
   tolua_constant(tolua_S,"OS_BADA",PLATFORM::OS_BADA);
   tolua_constant(tolua_S,"OS_BLACKBERRY",PLATFORM::OS_BLACKBERRY);
   tolua_constant(tolua_S,"OS_MAC",PLATFORM::OS_MAC);
   tolua_constant(tolua_S,"OS_NACL",PLATFORM::OS_NACL);
   tolua_constant(tolua_S,"OS_EMSCRIPTEN",PLATFORM::OS_EMSCRIPTEN);
   tolua_constant(tolua_S,"OS_TIZEN",PLATFORM::OS_TIZEN);
   tolua_constant(tolua_S,"OS_QT5",PLATFORM::OS_QT5);
   tolua_constant(tolua_S,"OS_WINRT",PLATFORM::OS_WINRT);
  tolua_endmodule(tolua_S);
  tolua_cclass(tolua_S,"AppUtils","AppUtils","",NULL);
  tolua_beginmodule(tolua_S,"AppUtils");
   tolua_function(tolua_S,"getInstance",tolua_luabinding_AppUtils_getInstance00);
   tolua_function(tolua_S,"getTargetPlatform",tolua_luabinding_AppUtils_getTargetPlatform00);
  tolua_endmodule(tolua_S);
 tolua_endmodule(tolua_S);
 return 1;
}


#if defined(LUA_VERSION_NUM) && LUA_VERSION_NUM >= 501
 TOLUA_API int luaopen_luabinding (lua_State* tolua_S) {
 return tolua_luabinding_open(tolua_S);
};
#endif

