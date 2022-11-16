--require("mobdebug").start()

--测试，最前面
--[[
print = function( ... )

    local out = ""

    local arg= {...}
    for  i,v in ipairs( arg ) do
        out = out .. " " ..  tostring(v)
    end



    cTools:myPrint( out )
end
--]]

--[[local CCLOG = function(...)
    --print (...)
    print( string.format(...) )
end--]]

local CCLOG = function(formatstring,...)
	local ret1,ret2 = pcall(string.format,formatstring,...)
	if(ret1)then
		print(ret2)
	else
		print("lua CCLOG error :",ret2)
	end
end




--android
local targetPlatform = cc.Application:getInstance():getTargetPlatform()
if not ((cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform))  then
    
    --关闭 jit
    if jit then
        jit.off()
        CCLOG("%s", "jit off" )
        CCLOG("%s", jit.status() )
    end
    

    
    
    --android 平台， lua oc 修复
    LuaObjcBridge = {}
    LuaObjcBridge.callStaticMethod = function ( class_name, method_name ,  info )
    
        if method_name == "createFolderIfNeed" then
            local folder_name = info.dirName
            local path = CCFileUtils:getInstance():getWritablePath() .. folder_name
            print ("create folder:" , path)
            cTools:createFolder_android( path )
            return true ,  string.format("%s created" , folder_name )
            
        elseif method_name == "exitGame" then
            cTools:exitGame_android()
            return true ,  "exit"
            
        else
            return false ,nil
        end

    end

    --android 平台, io.open 修复
    _raw_io_open = io.open

    io.open = function ( path, mode )
        --print ("io.open:" , path , mode )

        mode = mode or "r"
        local index = string.find( mode , 'r' )

        --读取文件，但是文件不存在，直接返回nil
        if index ~=nil and not cc.FileUtils:getInstance():isFileExist( path ) then
            return nil
        end

        local f = {}

        --读取文件数据
        local data = CCFileUtils:getInstance():getStringFromFile(path)

        --读方法
        function f:read()
            return data
        end
        --关闭方法
        function f:close()
            
        end

        --读方法，返回 伪造的file
        --写方法， 返回原先的 io.open 返回值
        if index ~= nil then
            return data and f or nil
        else
            return _raw_io_open( path, mode )
        end


    end
end






--一些工作
collectgarbage("setpause", 200 )
collectgarbage("setstepmul", 5000)

math.randomseed(os.time())

--ipad, iphone 设置不同的分辨率
local size = cc.Director:getInstance():getOpenGLView():getFrameSize()
cc.Director:getInstance():getOpenGLView():setDesignResolutionSize(960, 640,  size.width / size.height < 960/640 and cc.ResolutionPolicy.SHOW_ALL or cc.ResolutionPolicy.FIXED_HEIGHT )

--更新
_G.visibleSize = cc.Director:getInstance():getVisibleSize()
_G.origin =      cc.Director:getInstance():getVisibleOrigin()




--第三版加入的代码，应该在 增量更新结束后，再执行一遍===============================================================
if not cTools:isDebugVersion() then
    --release version
    print = function(   ) end

    cTools.showTimeConsume = function(   )
    end

    CCLOG = function() end
else
    --禁止使用 如下位运算
    --因为 lua bit 问题，这些 api 目前 禁用
    local bit = require("bit")
    bit.tobit =nil
    bit.tohex =nil
    bit.bxor =nil
    bit.arshift =nil
    bit.rol =nil
    bit.ror =nil
    bit.bswap =nil

    --[[
     bit.bnot  =nil
     bit.band  =nil
     bit.bor   =nil
     bit.lshift  =nil
     bit.rshift  =nil
     --]]
end


--rechange fps
cc.Director:getInstance():setAnimationInterval(1/30.0)


local ok, ret = LuaObjcBridge.callStaticMethod("AppController", "deviceModle" ,  {  } )
if ok then
    local model = ret
    CCLOG("model: %s" , model )
    if     (string.find(model,"iphone") and model < "iphone4" )
        or (string.find(model,"ipad")   and model < "ipad2" )
        or (string.find(model,"ipod")   and model < "ipod5" ) then
        cc.Texture2D:setDefaultAlphaPixelFormat( cc.TEXTURE2_D_PIXEL_FORMAT_RGB_A4444  ) 
    end
end
--第3版代码结束===============================================================


--进入 assetsManage 场景
local function assetDownload()
    cc.Director:getInstance():getScheduler():unscheduleScriptEntry(scriptEntry)
    
    local assetsDownLoad = require("assetsDownLoad")
    local scene = assetsDownLoad:create()
    
    cc.Director:getInstance():replaceScene(scene )
end



local function createNecessaryFolder()
    --创建目录
    LuaObjcBridge.callStaticMethod("AppController", "createFolderIfNeed" ,  { dirName = "tmp" } )
    
    
    --添加查询目录
    local path = CCFileUtils:getInstance():getWritablePath() .. "tmp/"
    CCFileUtils:getInstance():addSearchPath( path )
    
    
    --
    --local ok, ret =  LuaObjcBridge.callStaticMethod("AppController", "bundleResourcePath" ,  { } )
    --local path = ret .. "/cocostudio_images/"
    
    
    
    
    local path = "cocostudio_images_new/"
    CCFileUtils:getInstance():addSearchPath( path )
    
    local path = "cocostudio_images_missing/"
    CCFileUtils:getInstance():addSearchPath( path )
    
    
    --存放路径
    CLIENT_BASE_VERSION = cTools.getClientBaseVersion and cTools:getClientBaseVersion() or "1_0_0"
    
    print( "CLIENT_BASE_VERSION:" , CLIENT_BASE_VERSION )
    
    --展示版本，不更新任何资源
    if cTools:isPubAdminVersion() then
        CLIENT_BASE_VERSION = "9_9_9"
    end
    
    local saveFolder = "asset" .. CLIENT_BASE_VERSION
    local pathToSave = CCFileUtils:getInstance():getWritablePath() .. saveFolder
    
    --加入asset搜索目录
    local searchPaths = CCFileUtils:getInstance():getSearchPaths()
    local path = pathToSave
    
    table.insert( searchPaths , 1 , path )
    
    --for googleplay  version
    table.insert( searchPaths , 1 , path .. "/" .. "cocostudio_images_new/" )
    table.insert( searchPaths , 1 , path .. "/" .. "cocostudio_images_missing/" )
    
    for i,v in ipairs( searchPaths ) do
        
        print("init search path :" , i, string.format("-%s-" , v ))
    end
    
    --
    
    
    CCFileUtils:getInstance():setSearchPaths( searchPaths )
    
end

local function main()
    --开场scene
    local scene = cc.Scene:create()
    print(" runWithScene ")
    cc.Director:getInstance():runWithScene(scene )
    --cc.Director:getInstance():replaceScene(scene )
    
    createNecessaryFolder()
    
    --[[
    local path = CCFileUtils:getInstance():getWritablePath() .. "tmp/" .. "jitv.txt"
    require("jit.v").start(path)
    --]]
    
    scriptEntry = cc.Director:getInstance():getScheduler():scheduleScriptFunc( assetDownload , 0.1, false)
    
end


print( "execute main funciont " )


function __G__TRACKBACK__(msg)
    --[[
     CCLOG("----------------------------------------")
     CCLOG("LUA ERROR: " .. tostring(msg) .. "\n")
     --CCLOG(debug.traceback())
     CCLOG("----------------------------------------")
     --]]
    
    --被 socket.try 保护的，msg是一个table
    if type(msg) == "table" then
        return
    end
    
    
    CCLOG(debug.traceback())
    CCLOG("LUA ERROR: " .. tostring(msg) .. "\n")
    
    --[ [
    local targetPlatform = cc.Application:getInstance():getTargetPlatform()
    if (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform)  then
        local ok, ret =  LuaObjcBridge.callStaticMethod("AppController", "showAlert" ,  {text =tostring(msg)} )
        if ok then
        end
    end
    --]]
end


xpcall(main,  __G__TRACKBACK__)

