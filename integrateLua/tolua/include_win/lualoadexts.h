//
//  lualoadexts.h
//  PaintedSkin2
//
//  Created by qibinyi on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#ifndef __LUALOADEXTS_H_
#define __LUALOADEXTS_H_

#ifdef __cplusplus
extern "C" {
#endif
    
    #include "lauxlib.h"

    void luax_initpreload(lua_State *L);
    

#ifdef __cplusplus
}
#endif




#endif // __LUALOADEXTS_H_