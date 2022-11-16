
extern "C" {
#include "lua.h"
#include "lualib.h"
#include "lauxlib.h"
}

int main()
{
    int s=0;

    lua_State *L = lua_open();

    // load the libs
    luaL_openlibs(L);

    //run a Lua scrip here
    int ret0 = luaL_dofile(L,"foo.lua");

    printf("do file return: %d\n" , ret0 );
    int ret1 = luaL_dostring( L ,"print ('lua lua')" ) ;
    printf("do string return: %d\n" , ret1 );

    lua_close(L);

    return 0;
}

