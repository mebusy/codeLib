//
//  ScriptHandlerSample.cpp
//  iosLuaTest
//
//  Created by qibinyi on 12/02/2018.
//  Copyright © 2018 qibinyi. All rights reserved.
//

#include "ScriptHandlerSample.h"

#include "platform_header.h"
#include "LuaState.h"

ScriptHandlerSample::ScriptHandlerSample(void)
    : m_nScriptHandler(0)
{
    
}

void ScriptHandlerSample::registerScriptHandler(int nHandler)
{
    unregisterScriptHandler();
    m_nScriptHandler = nHandler;
    CCLog("[LUA] Add ScriptHandlerSample event handler: %d\n", m_nScriptHandler);
}

void ScriptHandlerSample::unregisterScriptHandler(void)
{
    if (m_nScriptHandler)
    {
        LuaState::getInstance().removeScriptHandler( m_nScriptHandler ) ;
        CCLog("[LUA] Remove ScriptHandlerSample event handler: %d\n", m_nScriptHandler);
        m_nScriptHandler = 0;
    }
}

int ScriptHandlerSample::getScriptHandler() {
    return m_nScriptHandler;
}

void ScriptHandlerSample::calLuaHandleTest()  {
    if(m_nScriptHandler!=0)
        LuaState::getInstance().executeFunctionByHandler(m_nScriptHandler, 0);
}
