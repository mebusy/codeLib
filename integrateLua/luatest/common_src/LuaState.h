//
//  cLuaState.hpp
//  iosLuaTest
//
//  Created by qibinyi on 2/7/18.
//  Copyright © 2018 qibinyi. All rights reserved.
//

#ifndef C_LuaState_h
#define C_LuaState_h

#ifdef __cplusplus
extern "C" {
#endif
    
#include "lua.h"
#include "tolua++.h"
#include "lualib.h"
#include "lauxlib.h"
#include "tolua_fix.h"

#ifdef __cplusplus
}
#endif


class LuaState
{
public:
    static LuaState& getInstance()
    {
        static LuaState instance;
        return instance;
    }
    LuaState();
    virtual ~LuaState();

    lua_State * state() { return L ; } ;

    int executeString(const char *codes);
    
    void setSearchPath(const char* path) ;
    void addSearchPath(const char* path) ;
    void addLuaLoader(lua_CFunction func);
    void clean(void) ;
    
    void removeScriptHandler(int nHandler);
    
    int executeFunction(int numArgs) ;
    /*
     call example: 
     pStack->pushCCObject(sender, "CCObject");
     pStack->pushInt(eventType);
     pStack->executeFunctionByHandler(m_lHandler, 2);
     */
    int executeFunctionByHandler(int nHandler, int numArgs);
protected:
    void pushInt(int intValue);
    void pushFloat(float floatValue);
    void pushBoolean(bool boolValue) ;
    void pushString(const char* stringValue) ;
    void pushString(const char* stringValue, int length);
    void pushNil(void) ;
    /*
    void pushCCObject(CCObject* objectValue, const char* typeName);
    void pushCCLuaValue(const CCLuaValue& value);
    void pushCCLuaValueDict(const CCLuaValueDict& dict);
    void pushCCLuaValueArray(const CCLuaValueArray& array);
    //*/
    bool pushFunctionByHandler(int nHandler) ;
    int reload(const char* moduleFileName) ;
private:
    void Init() ;
    lua_State * L ;
    int m_callFromLua;
} ;

#endif /* C_LuaState_h */
