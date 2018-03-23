//
//  cLuaState.cpp
//  iosLuaTest
//
//  Created by qibinyi on 2/7/18.
//  Copyright © 2018 qibinyi. All rights reserved.
//

#include "LuaState.h"

#include <string>

#include "FileUtils.h"

#include "platform_header.h"

#include "Cocos2dxLuaLoader.h"

#include "luabinding.h"
#include "testbinding.h"
//#include "tolua++.h"
#include "tolua_fix.h"

#if (CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID)
#include "CCLuaJavaBridge.h"
#endif

extern "C" {
#include "lualoadexts.h"
}

namespace {
    int lua_print(lua_State * luastate)
    {
        int nargs = lua_gettop(luastate);
        
        std::string t;
        for (int i=1; i <= nargs; i++)
        {
            if (lua_istable(luastate, i))
                t += "table";
            else if (lua_isnone(luastate, i))
                t += "none";
            else if (lua_isnil(luastate, i))
                t += "nil";
            else if (lua_isboolean(luastate, i))
            {
                if (lua_toboolean(luastate, i) != 0)
                    t += "true";
                else
                    t += "false";
            }
            else if (lua_isfunction(luastate, i))
                t += "function";
            else if (lua_islightuserdata(luastate, i))
                t += "lightuserdata";
            else if (lua_isthread(luastate, i))
                t += "thread";
            else
            {
                const char * str = lua_tostring(luastate, i);
                if (str)
                    t += lua_tostring(luastate, i);
                else
                    t += lua_typename(luastate, lua_type(luastate, i));
            }
            if (i!=nargs)
                t += "\t";
        }
        
        CCLog("[LUA-print] %s\n", t.c_str());
        
        return 0;
    }
}  // namespace {


LuaState::LuaState(void)
: L (NULL)
, m_callFromLua(0)
{
    Init();
}


LuaState::~LuaState(void) {
}

void LuaState::Init() {
    L = lua_open();
    // load the libs
    luaL_openlibs(L);
    toluafix_open(L);
    
    tolua_luabinding_open( L ) ;
    tolua_testbinding_open( L) ;
    
    luax_initpreload(L);
    
    
#if (CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID)
    LuaJavaBridge::luaopen_luaj( L );
#endif
    
    // Register our version of the global "print" function
    const luaL_reg global_functions [] = {
        {"print", lua_print},
        {NULL, NULL}
    };
    luaL_register( L , "_G", global_functions);
    
    
    //addSearchPath( (FileUtils::sharedFileUtils()->getResourcePath() + "scripts").c_str() );
    setSearchPath( "scripts" );
    // addSearchPath( "." );

    
    // add cocos2dx loader
    addLuaLoader(cocos2dx_lua_loader);
    
    // just test
    // CCLog( "res path: %s \n" , FileUtils::sharedFileUtils()->getResourcePath().c_str() ) ;
    // CCLog( "writable path: %s \n" , FileUtils::sharedFileUtils()->getWritablePath().c_str() ) ;
}

int LuaState::executeString(const char *codes)
{
    luaL_loadstring( L , codes);
    return executeFunction(0);
}

void LuaState::setSearchPath(const char* path)
{
    lua_State* m_state = L ;
    lua_getglobal(m_state, "package");                                  /* L: package */
    lua_getfield(m_state, -1, "path");                /* get package.path, L: package path */
    const char* cur_path =  lua_tostring(m_state, -1);
    lua_pushfstring(m_state, "%s/?.lua", path);            /* L: package path newpath */
    lua_setfield(m_state, -3, "path");          /* package.path = newpath, L: package path */
    lua_pop(m_state, 2);                                                /* L: - */
}

void LuaState::addSearchPath(const char* path)
{
    lua_State* m_state = L ;
    lua_getglobal(m_state, "package");                                  /* L: package */
    lua_getfield(m_state, -1, "path");                /* get package.path, L: package path */
    const char* cur_path =  lua_tostring(m_state, -1);
    lua_pushfstring(m_state, "%s;%s/?.lua", cur_path, path);            /* L: package path newpath */
    lua_setfield(m_state, -3, "path");          /* package.path = newpath, L: package path */
    lua_pop(m_state, 2);                                                /* L: - */
}

void LuaState::addLuaLoader(lua_CFunction func)
{
    if (!func) return;
    lua_State* m_state = L ;
    // stack content after the invoking of the function
    // get loader table
    lua_getglobal(m_state, "package");                                  /* L: package */
    lua_getfield(m_state, -1, "loaders");                               /* L: package, loaders */
    
    // insert loader into index 2
    lua_pushcfunction(m_state, func);                                   /* L: package, loaders, func */
    for (int i = lua_objlen(m_state, -2) + 1; i > 2; --i)
    {
        lua_rawgeti(m_state, -2, i - 1);                                /* L: package, loaders, func, function */
        // we call lua_rawgeti, so the loader table now is at -3
        lua_rawseti(m_state, -3, i);                                    /* L: package, loaders, func */
    }
    lua_rawseti(m_state, -2, 2);                                        /* L: package, loaders */
    
    // set loaders into package
    lua_setfield(m_state, -2, "loaders");                               /* L: package */
    
    lua_pop(m_state, 1);
}

void LuaState::clean(void)
{
    lua_settop(L, 0);
}


void LuaState::removeScriptHandler(int nHandler)
{
    toluafix_remove_function_by_refid(L, nHandler);
}


int LuaState::executeFunction(int numArgs)
{
    lua_State* m_state = L ;
    int functionIndex = -(numArgs + 1);
    if (!lua_isfunction(m_state, functionIndex))
    {
        CCLog("value at stack [%d] is not function\n", functionIndex);
        lua_pop(m_state, numArgs + 1); // remove function and arguments
        return 0;
    }
    
    int traceback = 0;
    lua_getglobal(m_state, "__G__TRACKBACK__");                         /* L: ... func arg1 arg2 ... G */
    if (!lua_isfunction(m_state, -1))
    {
        lua_pop(m_state, 1);                                            /* L: ... func arg1 arg2 ... */
    }
    else
    {
        lua_insert(m_state, functionIndex - 1);                         /* L: ... G func arg1 arg2 ... */
        traceback = functionIndex - 1;
    }
    
    int error = 0;
    ++m_callFromLua;
    error = lua_pcall(m_state, numArgs, 1, traceback);                  /* L: ... [G] ret */
    --m_callFromLua;
    if (error)
    {
        if (traceback == 0)
        {
            CCLog("[LUA ERROR] %s\n", lua_tostring(m_state, - 1));        /* L: ... error */
            lua_pop(m_state, 1); // remove error message from stack
        }
        else                                                            /* L: ... G error */
        {
            lua_pop(m_state, 2); // remove __G__TRACKBACK__ and error message from stack
        }
        return 0;
    }
    
    // get return value
    int ret = 0;
    if (lua_isnumber(m_state, -1))
    {
        ret = lua_tointeger(m_state, -1);
    }
    else if (lua_isboolean(m_state, -1))
    {
        ret = lua_toboolean(m_state, -1);
    }
    // remove return value from stack
    lua_pop(m_state, 1);                                                /* L: ... [G] */
    
    if (traceback)
    {
        lua_pop(m_state, 1); // remove __G__TRACKBACK__ from stack      /* L: ... */
    }
    
    return ret;
}

int LuaState::executeFunctionByHandler(int nHandler, int numArgs)
{
    lua_State* m_state = L ;
    int ret = 0;
    if (pushFunctionByHandler(nHandler))                                /* L: ... arg1 arg2 ... func */
    {
        if (numArgs > 0)
        {
            lua_insert(m_state, -(numArgs + 1));                        /* L: ... func arg1 arg2 ... */
        }
        ret = executeFunction(numArgs);
    }
    lua_settop(m_state, 0);
    return ret;
}


// PUSH


void LuaState::pushInt(int intValue)
{
    lua_pushinteger(L, intValue);
}

void LuaState::pushFloat(float floatValue)
{
    lua_pushnumber(L, floatValue);
}

void LuaState::pushBoolean(bool boolValue)
{
    lua_pushboolean(L, boolValue);
}

void LuaState::pushString(const char* stringValue)
{
    lua_pushstring(L, stringValue);
}

void LuaState::pushString(const char* stringValue, int length)
{
    lua_pushlstring(L, stringValue, length);
}

void LuaState::pushNil(void)
{
    lua_pushnil(L);
}

#if 0
void LuaState::pushCCObject(CCObject* objectValue, const char* typeName)
{
    toluafix_pushusertype_ccobject(m_state, objectValue->m_uID, &objectValue->m_nLuaID, objectValue, typeName);
}

void LuaState::pushCCLuaValue(const CCLuaValue& value)
{
    const CCLuaValueType type = value.getType();
    if (type == CCLuaValueTypeInt)
    {
        return pushInt(value.intValue());
    }
    else if (type == CCLuaValueTypeFloat)
    {
        return pushFloat(value.floatValue());
    }
    else if (type == CCLuaValueTypeBoolean)
    {
        return pushBoolean(value.booleanValue());
    }
    else if (type == CCLuaValueTypeString)
    {
        return pushString(value.stringValue().c_str());
    }
    else if (type == CCLuaValueTypeDict)
    {
        pushCCLuaValueDict(value.dictValue());
    }
    else if (type == CCLuaValueTypeArray)
    {
        pushCCLuaValueArray(value.arrayValue());
    }
    else if (type == CCLuaValueTypeCCObject)
    {
        pushCCObject(value.ccobjectValue(), value.getCCObjectTypename().c_str());
    }
}

void LuaState::pushCCLuaValueDict(const CCLuaValueDict& dict)
{
    lua_newtable(m_state);                                              /* L: table */
    for (CCLuaValueDictIterator it = dict.begin(); it != dict.end(); ++it)
    {
        lua_pushstring(m_state, it->first.c_str());                     /* L: table key */
        pushCCLuaValue(it->second);                                     /* L: table key value */
        lua_rawset(m_state, -3);                     /* table.key = value, L: table */
    }
}

void LuaState::pushCCLuaValueArray(const CCLuaValueArray& array)
{
    lua_newtable(m_state);                                              /* L: table */
    int index = 1;
    for (CCLuaValueArrayIterator it = array.begin(); it != array.end(); ++it)
    {
        pushCCLuaValue(*it);                                            /* L: table value */
        lua_rawseti(m_state, -2, index);          /* table[index] = value, L: table */
        ++index;
    }
}
#endif

bool LuaState::pushFunctionByHandler(int nHandler)
{
    lua_State* m_state = L ;
    toluafix_get_function_by_refid(m_state, nHandler);                  /* L: ... func */
    if (!lua_isfunction(m_state, -1))
    {
        CCLog("[LUA ERROR] function refid '%d' does not reference a Lua function\n", nHandler);
        lua_pop(m_state, 1);
        return false;
    }
    return true;
}

int LuaState::reload(const char* moduleFileName)
{
    lua_State* _state = L ;
    if ( 0  == moduleFileName || strlen(moduleFileName) == 0)
    {
        CCLog("moudulFileName is null \n");
        return 1;
    }
    
    lua_getglobal(_state, "package");                         /* L: package */
    lua_getfield(_state, -1, "loaded");                       /* L: package loaded */
    lua_pushstring(_state, moduleFileName);
    lua_gettable(_state, -2);                                 /* L:package loaded module */
    if (!lua_isnil(_state, -1))
    {
        lua_pushstring(_state, moduleFileName);               /* L:package loaded module name */
        lua_pushnil(_state);                                  /* L:package loaded module name nil*/
        lua_settable(_state, -4);                             /* L:package loaded module */
    }
    lua_pop(_state, 3);
    
    std::string name = moduleFileName;
    std::string require = "require \'" + name + "\'";
    return executeString(require.c_str());
}
