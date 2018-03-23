/*
** Lua binding: testbinding
** Generated automatically by tolua++-1.0.92 on Wed Feb 14 14:26:34 2018.
*/

#ifndef __cplusplus
#include "stdlib.h"
#endif
#include "string.h"

#include "tolua++.h"

/* Exported function */
TOLUA_API int  tolua_testbinding_open (lua_State* tolua_S);

#include "tolua_fix.h"
#include "ScriptHandlerSample.h"

/* function to release collected object via destructor */
#ifdef __cplusplus

static int tolua_collect_ScriptHandlerSample (lua_State* tolua_S)
{
 ScriptHandlerSample* self = (ScriptHandlerSample*) tolua_tousertype(tolua_S,1,0);
	Mtolua_delete(self);
	return 0;
}
#endif


/* function to register type */
static void tolua_testbinding_reg_types (lua_State* tolua_S)
{
 tolua_usertype(tolua_S,"ScriptHandlerSample");
 
}

/* method: new of class  ScriptHandlerSample */
#ifndef TOLUA_DISABLE_tolua_testbinding_ScriptHandlerSample_new00
static int tolua_testbinding_ScriptHandlerSample_new00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"ScriptHandlerSample",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  {
   ScriptHandlerSample* tolua_ret = (ScriptHandlerSample*)  Mtolua_new((ScriptHandlerSample)());
    tolua_pushusertype(tolua_S,(void*)tolua_ret,"ScriptHandlerSample");
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'new'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: new_local of class  ScriptHandlerSample */
#ifndef TOLUA_DISABLE_tolua_testbinding_ScriptHandlerSample_new00_local
static int tolua_testbinding_ScriptHandlerSample_new00_local(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"ScriptHandlerSample",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  {
   ScriptHandlerSample* tolua_ret = (ScriptHandlerSample*)  Mtolua_new((ScriptHandlerSample)());
    tolua_pushusertype(tolua_S,(void*)tolua_ret,"ScriptHandlerSample");
    tolua_register_gc(tolua_S,lua_gettop(tolua_S));
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'new'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: registerScriptHandler of class  ScriptHandlerSample */
#ifndef TOLUA_DISABLE_tolua_testbinding_ScriptHandlerSample_registerScriptHandler00
static int tolua_testbinding_ScriptHandlerSample_registerScriptHandler00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"ScriptHandlerSample",0,&tolua_err) ||
     (tolua_isvaluenil(tolua_S,2,&tolua_err) || !toluafix_isfunction(tolua_S,2,"LUA_FUNCTION",0,&tolua_err)) ||
     !tolua_isnoobj(tolua_S,3,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  ScriptHandlerSample* self = (ScriptHandlerSample*)  tolua_tousertype(tolua_S,1,0);
  LUA_FUNCTION handler = (  toluafix_ref_function(tolua_S,2,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'registerScriptHandler'", NULL);
#endif
  {
   self->registerScriptHandler(handler);
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'registerScriptHandler'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: unregisterScriptHandler of class  ScriptHandlerSample */
#ifndef TOLUA_DISABLE_tolua_testbinding_ScriptHandlerSample_unregisterScriptHandler00
static int tolua_testbinding_ScriptHandlerSample_unregisterScriptHandler00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"ScriptHandlerSample",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  ScriptHandlerSample* self = (ScriptHandlerSample*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'unregisterScriptHandler'", NULL);
#endif
  {
   self->unregisterScriptHandler();
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'unregisterScriptHandler'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: getScriptHandler of class  ScriptHandlerSample */
#ifndef TOLUA_DISABLE_tolua_testbinding_ScriptHandlerSample_getScriptHandler00
static int tolua_testbinding_ScriptHandlerSample_getScriptHandler00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"ScriptHandlerSample",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  ScriptHandlerSample* self = (ScriptHandlerSample*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'getScriptHandler'", NULL);
#endif
  {
   int tolua_ret = (int)  self->getScriptHandler();
   tolua_pushnumber(tolua_S,(lua_Number)tolua_ret);
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'getScriptHandler'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: calLuaHandleTest of class  ScriptHandlerSample */
#ifndef TOLUA_DISABLE_tolua_testbinding_ScriptHandlerSample_calLuaHandleTest00
static int tolua_testbinding_ScriptHandlerSample_calLuaHandleTest00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"ScriptHandlerSample",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  ScriptHandlerSample* self = (ScriptHandlerSample*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'calLuaHandleTest'", NULL);
#endif
  {
   self->calLuaHandleTest();
  }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'calLuaHandleTest'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* Open function */
TOLUA_API int tolua_testbinding_open (lua_State* tolua_S)
{
 tolua_open(tolua_S);
 tolua_testbinding_reg_types(tolua_S);
 tolua_module(tolua_S,NULL,0);
 tolua_beginmodule(tolua_S,NULL);
  #ifdef __cplusplus
  tolua_cclass(tolua_S,"ScriptHandlerSample","ScriptHandlerSample","",tolua_collect_ScriptHandlerSample);
  #else
  tolua_cclass(tolua_S,"ScriptHandlerSample","ScriptHandlerSample","",NULL);
  #endif
  tolua_beginmodule(tolua_S,"ScriptHandlerSample");
   tolua_function(tolua_S,"new",tolua_testbinding_ScriptHandlerSample_new00);
   tolua_function(tolua_S,"new_local",tolua_testbinding_ScriptHandlerSample_new00_local);
   tolua_function(tolua_S,".call",tolua_testbinding_ScriptHandlerSample_new00_local);
   tolua_function(tolua_S,"registerScriptHandler",tolua_testbinding_ScriptHandlerSample_registerScriptHandler00);
   tolua_function(tolua_S,"unregisterScriptHandler",tolua_testbinding_ScriptHandlerSample_unregisterScriptHandler00);
   tolua_function(tolua_S,"getScriptHandler",tolua_testbinding_ScriptHandlerSample_getScriptHandler00);
   tolua_function(tolua_S,"calLuaHandleTest",tolua_testbinding_ScriptHandlerSample_calLuaHandleTest00);
  tolua_endmodule(tolua_S);
 tolua_endmodule(tolua_S);
 return 1;
}


#if defined(LUA_VERSION_NUM) && LUA_VERSION_NUM >= 501
 TOLUA_API int luaopen_testbinding (lua_State* tolua_S) {
 return tolua_testbinding_open(tolua_S);
};
#endif

