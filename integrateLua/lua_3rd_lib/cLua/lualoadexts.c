//
//  lualoadexts.c
//  PaintedSkin2
//
//  Created by qibinyi on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#include "lualoadexts.h"

// luasocket
#include "luasocket.h"
#include "mime.h"
#include "md5.h"
#include "ldes56.h"

extern int luaopen_lcurl(lua_State *L) ;

static luaL_Reg luax_preload_list[] = {
    {"socket.core", luaopen_socket_core},
    {"mime.core", luaopen_mime_core},
    {"md5.core", luaopen_md5_core},
    {"des56", luaopen_des56},
    {"lcurl", luaopen_lcurl},

    {NULL, NULL}
};

void luax_initpreload(lua_State *L)
{
    luaL_Reg* lib = luax_preload_list;
    luaL_findtable(L, LUA_GLOBALSINDEX, "package.preload",
                   sizeof(luax_preload_list)/sizeof(luax_preload_list[0])-1);
    for (; lib->func; lib++) {
        lua_pushstring(L, lib->name);
        lua_pushcfunction(L, lib->func);
        lua_rawset(L, -3);
    }
    lua_pop(L, 1);
}
