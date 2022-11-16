//
//  ScriptHandlerSample.hpp
//  iosLuaTest
//
//  Created by qibinyi on 12/02/2018.
//  Copyright © 2018 qibinyi. All rights reserved.
//

#ifndef ScriptHandlerSample_h
#define ScriptHandlerSample_h

// #include <stdio.h>

class ScriptHandlerSample {
public:
    ScriptHandlerSample(void);
    virtual void registerScriptHandler(int handler);
    virtual void unregisterScriptHandler(void);
    int getScriptHandler() ;
    void calLuaHandleTest() ;
private:
    int m_nScriptHandler;
} ;

#endif /* ScriptHandlerSample_hpp */
