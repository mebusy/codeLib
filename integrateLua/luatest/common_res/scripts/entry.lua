require( "init" )

print ( "i'm entry.lua 2" )


function test()

    print ( "res path:" , FileUtils:sharedFileUtils():getResourcePath()  )
    print ( "writable path:" , FileUtils:sharedFileUtils():getWritablePath()  )

    local path = FileUtils:sharedFileUtils():getResourcePath() ..  "scripts/entry.lua"
    --print (path)
    local f = io.open( path )
    if f ~= nil then
        local data = f:read("*all")
        f:close()
        -- print (data)
    end

    local shs = ScriptHandlerSample()
    --print (shs)
    shs:registerScriptHandler( function()  print("lua callback");  end )
    shs:calLuaHandleTest()
    shs:unregisterScriptHandler()

    local platform = AppUtils:getInstance():getTargetPlatform()
    print ( "platform is " , platform )

    if platform == PLATFORM.OS_ANDROID then
        local luaj = require "tools.luaj"
        -- print (luaj)
        local ret , val  = luaj.callStaticMethod("org/cocos2dx/lib/Cocos2dxHelper", "getFloatForKey" , { "testkey" , 1.3 }  ,  "(Ljava/lang/String;F)F" )
        print( "luaj ret: " , ret , val  )
    end

    -- md5 test
    local md5 =require ('md5')
    local md5_val  = md5.sumhexa ( "ABC" )
    print ("md5:" , md5_val )

    -- mime test
    local mime = require'mime'
    print ( "base64 ABC: " , mime.b64( "ABC" ) )

    -- lua socket test
    local http=require("socket.http")
    local data,code = http.request(  "https://www.baidu.com")
    print("status code",  code)

    if platform == PLATFORM.OS_ANDROID then
        local luaj = require "tools.luaj"
        -- print (luaj)
        local ret  = luaj.registerLuaFunction( "javaLuaCallbackTest_luacallback"  , function(msg) local _m=mime.unb64( msg ); print(_m) end )
        print( "register lua ret: " , ret    )
        local ret  = luaj.registerLuaFunction( "javaLuaCallbackTest_luacallback"  , function(msg) local _m=mime.unb64( msg ); print(_m) end )
        print( "register lua ret: " , ret    )

        local ret , val  = luaj.callStaticMethod("com/apixel/luaTest/Main", "javaLuaCallbackTest" , 
            { "javaLuaCallbackTest_luacallback" , "lua msg"}  ,  "(Ljava/lang/String;Ljava/lang/String;)V" )
        print( "luaj ret: " , ret , val  )       
    end

    local des56 = require 'des56'
    local key = '&3g4&gs*&3'
    local crypt = des56.crypt('1234567890', key)
    print ( "crypt" , crypt )
    local decrypt = des56.decrypt( crypt , key)
    print ('decrypt' , decrypt)

    -- The mode string can also have a 'b' at the end, 
    -- which is needed in some systems to open the file in binary mode. 
    -- This string is exactly what is used in the standard C function fopen.
    local path = FileUtils:sharedFileUtils():getWritablePath()  .. "test.bin"
    local f = io.open(path, "wb")
    if f then
        local t = f:write( "abc\0def" )
        f:close()
    end
    local path = FileUtils:sharedFileUtils():getWritablePath() .. "test.bin"
    local f = io.open(path, "rb")
    if f then
        local data  = f:read("*all")
        f:close()

        print (data , #data , string.sub(data, 1,2), string.sub(data, 3,3), string.sub(data , 4,4)  )
        if string.sub(data ,4,4)  ~= "\0" or #data ~= 7 then
            error ( "find data error" )
        end
    else
        error( "find not found !!" )
    end

    -- local xxx  = require( "xxx" ) will not work here
    -- because the module will be deleted from package.loaded RIGHT BEFORE `require` return !!!
    require("testM1")
    print ( "testM1" , testM1 )
    require("testM1")
    print ( "testM1" , testM1 )
    

end



function globalFuncTest()
    print "call globalFuncTest"
    return 99 
end

globalTestValue = 77

xpcall(test,  __G__TRACKBACK__)
