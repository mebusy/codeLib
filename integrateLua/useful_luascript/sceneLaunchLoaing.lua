
--适配 1.0 客户端
CLIENT_BASE_VERSION = cTools.getClientBaseVersion and cTools:getClientBaseVersion() or "1_0_0"

local P = {}
sceneLaunchLoaing = P


-- no more external access after this point
setmetatable(P, {__index = _G})
setfenv(1, P)

-- refreshServerList 方法中，有初始服务器选择策略

local last_assets_checkSum = 0
local last_assets_localAsset = {} 
-- run
local download_data =
[[
local global_data = require("global_data")
global_data.game_servers = {
    {
        {
            name = require("gameText").getGameText("ID_TEXT_SCENELAUNCHLOAING_000"),
            
        } ,
    } ,
}
]]

--版署版本
if cTools:isPubAdminVersion() then
    
    download_data =
[[
    local global_data = require("global_data")
    global_data.game_servers = {
        {
            {
                name = require("gameText").getGameText("ID_TEXT_SCENELAUNCHLOAING_001"),
                ip =   "101.231.186.13" ,
                port = 7100 ,
                serverid = "pubAdmin_7100"
            } ,
        } ,
    }
]]
end

local http_request = function ( _url  )
    -- load the modules

    local http = require("socket.http")
    local ltn12 = require("ltn12")

    http.TIMEOUT = 8

    -- b returns some useless page telling about the denied access,
    -- h returns authentication information
    -- and c returns with value 401 (Authentication Required)

    -- GET or POST

    local b, c, h = http.request( _url   )

    if b~=nil then
        -- for empty array with form '[]' will cause json error
        b=string.gsub(b, "%[%s*%]", "%{%}")
        
        -- for url escape
        local url = require("socket.url")
        b =  url.unescape(b)
    end

    -- return necessary info
    return b, c, h
end

function refreshServerList()
    --加载初始列表
    local data = download_data  --先下载
    if data ~=nil then
        local func =  loadstring(data)
        func()
    end
    
    if not cTools:isPubAdminVersion() then
        --下载更新服务器列表
        local channel = SdkManager:getLoginChannel()
        print( "reflesh server list for channel:" , channel )
        
        local assetsDownLoad = require("assetsDownLoad")
        
        
        -- 选择服务器列表 下载服务器
        local all_dl_server_ip = {
            itools="update1.nbahero.com",
            dsuc="101.231.186.13",
        }
        
        local http_download_server = all_dl_server_ip[channel] or "8.8.8.8"
        
        --正式版本，8080端口
        local url = string.format( "http://%s:8080/download/server_configs/server_config_%s.txt" ,  http_download_server , channel )
        --内网版本,固定ip , 80端口
        --dsuc版本
        
        --暂时,都连接 13 服务器
        --if cTools:isLoginInner() or channel == "dsuc" then
              url = string.format( "http://%s/download/server_configs/server_config_%s.txt" ,  "101.231.186.13" , channel )
        --end
        
        
        local b,c,h = http_request( url )
        --print( b,c,h )
        if c == 200 then
            --更新服务器列表
            local function update2DownloadServerList()
                local func =  loadstring(b)
                func()
                
                --粗略的选择 最后一个区，最后一个服务器
                cGameSave.cur_server[1] = #global_data.game_servers
                cGameSave.cur_server[2] = #global_data.game_servers[cGameSave.cur_server[1]]
                
                --根据server id , 调整 服务器索引
                if cGameSave.serverid ~= "" then
                    
                    for j , area_info in ipairs( global_data.game_servers ) do
                        for i, server_info in ipairs( area_info ) do
                            --找到对应的服务器
                            if server_info.serverid == cGameSave.serverid then
                                cGameSave.cur_server[1] = j
                                cGameSave.cur_server[2] = i
                                cGameSave.area_id = server_info.area_id
                                
                            end
                        end
                    end
                
                else
                    --新手默认选区
                    --默认选中的服务器
                    local bDefault = false
                    local bNew = false
                    
                    --[ [
                    for j , area_info in ipairs( global_data.game_servers ) do
                        for i, server_info in ipairs( area_info ) do
                            
                            if server_info.isDefault then
                                cGameSave.cur_server[1] = j
                                cGameSave.cur_server[2] = i
                                cGameSave.serverid  = server_info.serverid
                                cGameSave.area_id = server_info.area_id

                                bDefault = true
                            end
                        end
                    end
                    
                    --没有默认选中的服务器
                    --选择新区
                    if not bDefault then
                        local cChooseArea = require("cChooseArea")
                        for j , area_info in ipairs( global_data.game_servers ) do
                            for i, server_info in ipairs( area_info ) do
                                
                                if (server_info.status or 0) < cChooseArea.CODE_FULL then
                                    print("选择新服务")
                                    cGameSave.cur_server[1] = j
                                    cGameSave.cur_server[2] = i
                                    cGameSave.serverid  = server_info.serverid
                                    cGameSave.area_id = server_info.area_id
                                    bNew = true
                                end -- endif
                            end -- end for i
                        end -- end forj
                    end
                    --]]
                    --找不到新服
                    if not bDefault and not bNew then
                        local latest_time = "00001230"
                        local cChooseArea = require("cChooseArea")
                        for j , area_info in ipairs( global_data.game_servers ) do
                            for i, server_info in ipairs( area_info ) do
                                if server_info.start_time and server_info.start_time >  latest_time then
                                    latest_time = server_info.start_time
                                    
                                    print("选择服务器 , 开服时间:" , server_info.start_time )
                                    cGameSave.cur_server[1] = j
                                    cGameSave.cur_server[2] = i
                                    cGameSave.serverid  = server_info.serverid
                                    cGameSave.area_id = server_info.area_id
                                    
                                end
                                
                                --
                            end -- end for i
                        end -- end forj
                    end
                    
                end
                
                print("cGameSave.serverid",cGameSave.serverid,cGameSave.area_id)
                
                --最后存盘
                cGameSave.save_record()
                
            end -- end update2DownloadServerList
        
            xpcall( update2DownloadServerList , mylib.__G__TRACKBACK__ )
            
        end -- if c == 200 then
    end

    --会自动读取记录
    local cGameSave = require("cGameSave")
    
    

    
    --做越界处理
    local global_data = require("global_data")
    
    if cGameSave.cur_server[1] > #global_data.game_servers then
        cGameSave.cur_server[1] = 1
    end
    if cGameSave.cur_server[2] > #global_data.game_servers[cGameSave.cur_server[1]] then
        cGameSave.cur_server[2] = 1
    end


    
    
end


local scriptEntry

local function swith2NextScene()
    cc.Director:getInstance():getScheduler():unscheduleScriptEntry(scriptEntry)
    
    --1.0客户端，强制更新
    
    local targetPlatform = cc.Application:getInstance():getTargetPlatform()
    if (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform)  then
        local bundleVersion
        
        local ok, ret =  LuaObjcBridge.callStaticMethod("AppController", "getBundleVersion" ,  { } )
        if ok then
            bundleVersion =   ret
        else
            local ffi_func = require("ffi_func")
            bundleVersion =  ffi_func.getBundleVersion()
        end
        
        --必须确保获取到 本地版本号
        if not bundleVersion then
            mylib:callLater( function() showAlert(require("gameText").getGameText("ID_TEXT_ASSETSDOWNLOAD_003")) end, 0.3)
            return
        end
        
        if true then --bundleVersion == 1 then
            --1.0版本 强制更新
            
            print( "1.0版本 强制更新" )
            
            local http = require("socket.http")
            http.TIMEOUT = 10
            
            --版本检查
            local url = string.format("http://%s/%s/asset_check_version.txt", assetsDownLoad.download_server_ip , assetsDownLoad.download_path )
            local b, c, h = http.request( url   )
            if c == 200 and b~=nil then
                local iVersionRequirement = string.gsub( b , "%s" , "" )
                
                print ( "iVersionRequirement:" , iVersionRequirement , "bundleVersion:" , bundleVersion  )
                --版本号比较
                if bundleVersion < iVersionRequirement then
                    local function openAppStore()
                        local appID = "938034815"
                        local url = string.format( "http://itunes.apple.com/app/id%s" , appID )
                        
                        local ok, ret =  LuaObjcBridge.callStaticMethod("AppController", "openAppStore" ,  { url  = url } )
                        if ok then
                            print( "openAppStore"  )
                        else
                            local ffi_func = require("ffi_func")
                            ffi_func.openAppStore( url )
                        end
                        
                    end --end function openAppStore()
                    
                    mylib:callLater( function() showAlert(require("gameText").getGameText("ID_TEXT_SCENELAUNCHLOAING_003") ,openAppStore , nil,  require("gameText").getGameText("ID_TEXT_ASSETSDOWNLOAD_005")  ) end, 0.3)
                    return
                end
                
                
            else
                --7100版本和 debug版，为了调试方便，不做这个判断
                if (cTools:isDebugVersion()  or  game_config.IS_LITE_VERSION ) then -- false and
                else
                    mylib:callLater( function() showAlert(require("gameText").getGameText("ID_TEXT_SCENELAUNCHLOAING_005")) end, 0.3)
                    return
                end
            end
        end
        
    end
    
    
    --android
    --需要底层代码支持
    if cc.PLATFORM_OS_ANDROID == targetPlatform  and cTools.canAccessPasteboard_android  then
        
        local http = require("socket.http")
        http.TIMEOUT = 10
        
        --版本检查
        local url = string.format("http://%s/%s/asset_check_version.txt", assetsDownLoad.download_server_ip , assetsDownLoad.download_path )
        local b, c, h = http.request( url   )
        if c == 200 and b~=nil then
            local iVersionRequirement = string.gsub( b , "%s" , "" )
            
            local bundleVersion
            
            local luaj = require("luaj")
            -- . 要换成 /
            local className="com/dst/nbahero/NBAHeroMain"
            local params={ }
            local desc="()Ljava/lang/String;"
            
            local ok, ret =luaj.callStaticMethod(className,"getBundleVersion",params , desc )
            
            print( "call getBundleVersion:" ,  ok, ret )
            
            if ok then
                bundleVersion =  ret
            end
            
            --必须确保获取到 本地版本号
            if not bundleVersion then
                mylib:callLater( function() showAlert(require("gameText").getGameText("ID_TEXT_ASSETSDOWNLOAD_003")) end, 0.3)
                return
            end
            
            print ( "iVersionRequirement:" , iVersionRequirement , "bundleVersion:" , bundleVersion  )
            --版本号比较
            if bundleVersion < iVersionRequirement then
                local function openAppStore()
                local url = "http://www.nbahero.com"
                
                --配置所有android渠道，默认官网
                local all_urls = {
                    hupu="http://www.hupu.com",
                }
                if all_urls[ SdkManager:getLoginChannel() ] then
                    url = all_urls[ SdkManager:getLoginChannel() ]
                end
                --配置所有android渠道
                
                
                local luaj = require("luaj")
                -- . 要换成 /
                local className="com/dst/nbahero/NBAHeroMain"
                local params={ url }
                local desc="(Ljava/lang/String;)V"
                
                local ok, ret =luaj.callStaticMethod(className,"openAppStore",params , desc )
                
                if ok then
                    print( "openAppStore"  )
                end
            end --end function openAppStore()
            
            mylib:callLater( function() showAlert(require("gameText").getGameText("ID_TEXT_ASSETSDOWNLOAD_004") ,openAppStore , nil,  require("gameText").getGameText("ID_TEXT_ASSETSDOWNLOAD_005")  ) end, 0.3)
            return
        end
        
        
        else
            --7100版本和 debug版，为了调试方便，不做这个判断
            if (cTools:isDebugVersion() or  game_config.IS_LITE_VERSION   ) then -- false and
                else
                mylib:callLater( function() showAlert(require("gameText").getGameText("ID_TEXT_SCENELAUNCHLOAING_009")) end, 0.3)
                return
            end
        end
    end


    --注册
    local ok, ret =  LuaObjcBridge.callStaticMethod("AppController", "registerLocalNotification" , {})

    local cGameSave = require("cGameSave")

    refreshServerList()
     --[[
    local data = download_data  --先下载
    if data ~=nil then
        local func =  loadstring(data)
        func()
    end
    --]]
    
    --记录到 global_data 中
    --global_data.game_servers = nil

    --为了配合 videoplayer , 改变 分辨率适配
    --ipad, iphone 设置不同的分辨率 size.width / size.height < 1.4 -> size.width / size.height < 960/640
    local size = cc.Director:getInstance():getOpenGLView():getFrameSize()
    cc.Director:getInstance():getOpenGLView():setDesignResolutionSize(960, 640,  size.width / size.height < 960/640 and cc.ResolutionPolicy.SHOW_ALL or cc.ResolutionPolicy.FIXED_HEIGHT )

    --更新
    _G.visibleSize = cc.Director:getInstance():getVisibleSize()
    _G.origin =      cc.Director:getInstance():getVisibleOrigin()


    --测试用的 mainMenu scene
    --load sceneMainMenu module
    local sceneMainMenu = require("sceneMainMenu")

    --进入游戏 登录界面
    if true then
        local SceneManager = require("SceneManager")
        SceneManager:tranforScene(SceneManager.scene_mode.login , nil , nil , true )
    else
    
        scene = sceneMainMenu:create()
    
        cc.Director:getInstance():replaceScene(scene ) --测试
        --SceneManager:tranforScene(SceneManager.scene_mode.guild  )
    end
    

    --mac 版本专用, 不影响 iOS版本
    if cc.PLATFORM_OS_MAC == targetPlatform then
        --Mac版本, editbos bug:  password 类型，不能正确获取
        cc.EDITBOX_INPUT_FLAG_PASSWORD = cc.EDITBOX_INPUT_MODE_EMAILADDR
        
        --所有IOS 功能，Mac 版本也用
        cc.PLATFORM_OS_IPAD = cc.PLATFORM_OS_MAC
    end

    --性能优化用
    --改变 addSpriteFrames 方法
    --[ [

    local raw_func_addSpriteFrames =  cc.SpriteFrameCache:getInstance().addSpriteFrames
    cc.SpriteFrameCache:getInstance().addSpriteFrames = function( sender , file_plist )
        local cache = cc.SpriteFrameCache:getInstance()
        if file_plist == "all_item_icon.plist" and cache:getSpriteFrame( "Item-Diamond-1.png" ) then
            --print( file_plist , "已经载入" )
        elseif file_plist == "activeskill.plist" and cache:getSpriteFrame( "activeskill_500001.png" ) then
        elseif file_plist == "passive_skill.plist" and cache:getSpriteFrame( "passiveSkill_1001.png" ) then
        elseif file_plist == "all_player_portrait_130.plist" and cache:getSpriteFrame( "nbahead_ip_100018.png" ) then
        elseif file_plist == "all_sanguo_portrait_102.plist" and cache:getSpriteFrame( "sanguo_portrait_1.png" ) then
        elseif file_plist == "all_equipment_icon.plist" and cache:getSpriteFrame( "Eqpt-AGIshoes-2.png" ) then
        elseif file_plist == "all_sanguo_Technical_102.plist" and cache:getSpriteFrame( "Technical_510001.png" ) then
        elseif file_plist == "all_sanguo_Technicaldebris_114.plist" and cache:getSpriteFrame( "Technicaldebris_510001.png" ) then
        elseif file_plist == "all_tactics_icon_80.plist" and cache:getSpriteFrame( "tactics_icon_101.png" ) then
        
        else
            print( "载入sprite sheet 资源:" , file_plist  )
            raw_func_addSpriteFrames( sender , file_plist )
        end
    end
    --]]

    --[ [
    --防止 ccui.ImageView.loadTexture crash
    local raw_func_ccuiImage_loadTexture = ccui.ImageView.loadTexture
    ccui.ImageView.loadTexture = function( sender, imgName , resType )

        resType = tonumber(resType or ccui.TextureResType.localType)
        
        --会有 imgName == ""的情况
        if (not imgName) or  string.len(imgName) <=1 then
            raw_func_ccuiImage_loadTexture( sender, imgName , resType )
            return
        end

        local rawImgName = imgName
        local bError = false


        if resType == ccui.TextureResType.localType then
            local spr = cc.Sprite:create( imgName )
            if not spr then
                
                bError = true
                
                imgName = "GUI/image.png"
            end
        elseif resType == ccui.TextureResType.plistType then
            local cache = cc.SpriteFrameCache:getInstance()
            if not cache:getSpriteFrame( imgName ) then
                
                bError = true
                
                imgName = "GUI/image.png"
                resType = ccui.TextureResType.localType
            end
        end
        --print( "raw_func_ccuiImage_loadTexture:" , imgName , resType )
        raw_func_ccuiImage_loadTexture( sender, imgName , resType )

        --loadTexture 错误，显示提示
        if bError then
            local tips_layer = require("tips_layer")
            tips_layer.createFadeTips( require("gameText").getGameText("ID_TEXT_SCENELAUNCHLOAING_010") .. rawImgName , nil, true  )
        end
    end


    --繁体版本
    if game_config.bIS_TRADITIONAL_VERSION then
        local  raw_widgetFromJsonFile = ccs.GUIReader.widgetFromJsonFile
        ccs.GUIReader.widgetFromJsonFile = function( self , filename  )
        
                                                local tmp_json =  filename .. "." .. game_config.CUR_LANG
                                                
                                                --没有处理
                                                if not _G.table_tradition_ccsjson then
                                                    _G.table_tradition_ccsjson = {}
                                                end
                                                
                                                if not _G.table_tradition_ccsjson [ filename ] then
                                                    _G.table_tradition_ccsjson [ filename ] = 1
                                                

                                                    local dic_s2t_plus =  {
                                                        ["充值"] ="储值" ,  --NBA-2646
                                                        
                                                        ["刷%s新"] = "更新" , --NBA-2656
                                                        ["球员舍"] = "球員室" ,
                                                        ["制造中心"] = "生產中心" ,
                                                        ["邮件"] = "電郵"  ,
                                                        ["邮箱"] = "電郵"  ,
                                                        ["城池"] = "城市" ,
                                                        
                                                        ["服务器"] = "伺服器" , --1
                                                        
                                                        ["界面"] = "介面",        --1
                                                        ["激活"] = "啟動" ,       --1
                                                        ["信息"] = "資訊" ,  --1
                                                        ["默认"] = "預設" , --1
                                                        
                                                        
                                                        ["被克"]  ="被壓制",
                                                        ["发件人"] = "發信者",
                                                        
                                                        ["清零"]  = "歸零",

                                                        ["作为"]  = "身為" ,
                                                        ["联系"]  = "聯絡" ,
                                                        
 
                                                        ["克制"] = "壓制" ,
 
 
                                                        
                                                        ["扣篮"] =  "灌籃" , --a  abcd 要是变更, 特效动画，game_text 文本都要修改
                                                        ["盖帽"] = "封阻" ,  --b
                                                        ["首發"]  = "先發" ,
                                                        ["菜单"] = "選單" ,
                                                        
                                                        ["头戴"] = "頭飾" ,
                                                        ["常规"] = "例行" ,
                                                        ["抢断"] = "抄截" ,  --c
                                                        ["查找"] = "查詢" ,
                                                        -- "盖帽" = "阻攻" ,
                                                        ["干扰"] = "幹擾" ,  --d
                                                        ["支持"] = "支援" , 
                                                        ["快船"] = "快艇" ,
                                                        ["查看规则"] =  "規則說明" ,
                                                        ["刷新"] = "更新" ,
                                                        ["首发"] = "先發" ,
                                                        ["充 值"] ="储 值" ,
                                                        
                                                    }

                                                    --hk
                                                    local dic_s2t_plus_hk = {
                                                        ["扣篮"] = "入樽" ,
                                                    }
                                                    
                                                    --找到要加载的文件
                                                    local f = io.open( cc.FileUtils:getInstance():fullPathForFilename( filename )  , "r")
                                                    if f then
                                                        local data = f:read("*all")
                                                        f:close()
                                                        


                                                        -- 通用翻译
                                                        for k , v in pairs(dic_s2t_plus) do
                                                            data = string.gsub( data , k , v  )
                                                        end

                                                        -- 香港特有 翻译
                                                        if game_config.CUR_LANG == game_config.ALL_LANG.HK then
                                                            for k , v in pairs(dic_s2t_plus_hk ) do
                                                                data = string.gsub( data , k , v  )
                                                                data = string.gsub( data , dic_s2t_plus[k] , v  )
                                                            end
                                                        end

                                                        --save
                                                        
                                                        local path = CCFileUtils:getInstance():getWritablePath() .. "tmp/" --
                                                        local fw = io.open( path .. tmp_json , "w")
                                                        fw:write(data)
                                                        fw:close()
                                                        
                                                    end
                                                    

                                                    
                                                end
        
                                                return raw_widgetFromJsonFile( self, tmp_json )
                                            end

        --cocos studio 动画会从 json 文件中读取 animation 组件，
        --繁体版本 会从一个临时的 .tradi json 文件中解析 cocostudio ui, 所以 getActionByName 也需要相应修改一下
        local raw_getActionByName =  ccs.ActionManagerEx.getActionByName
        ccs.ActionManagerEx.getActionByName = function( self , json_file , anim_name )
                    return raw_getActionByName(  self , json_file .. ".tradi" , anim_name )
                end
    end

    local ffi_func = require("ffi_func")
    local systemVersion = tostring( ffi_func.getSystemVersion()  or 0 )
    print("当前系统版本号:" , systemVersion  )
    if systemVersion > "9" then
        print( "ios9 需要特殊处理" )
        game_config.IS_CHANGE_EDIT = true
    end

    --如果当前客户端是 修复了 ios9 bug的客户端
    local targetPlatform = cc.Application:getInstance():getTargetPlatform()
    if (cc.PLATFORM_OS_IPHONE == targetPlatform)  then
        local ok, ret =  LuaObjcBridge.callStaticMethod("AppController", "getBundleVersion" ,  { } )
        if ok then
            local bundleVersion =  ret
            if bundleVersion >= "1.6" then
                game_config.IS_CHANGE_EDIT = false
            end
        end
    end

    --预处理
    mylib:preHandleNodeWidgetPlayerCenter()

    --]]

end


-- 界面居中
local function setUI2Center(  _widget )
    
    _widget:setAnchorPoint( cc.p( 0.5, 0.5 ) )
    _widget:setPosition( cc.p( origin.x + visibleSize.width/2, origin.y + visibleSize.height/2 ) )
    
end


function showAlert(text , func_callBack_close , func_callBack_confirm_with_cancel , sure_text )
    
    _widget = ccs.GUIReader:getInstance():widgetFromJsonFile( "Global_Mention.json" )
    _widget:getChildByName("Background_Shadow"):setVisible(false)
    
    setUI2Center(_widget)
    
    local label  = _widget:getChildByName("Mention_Text")
    label:setVisible(true)
    label:ignoreContentAdaptWithSize(false)
    label:setSize( cc.size(270 , 210))
    
    label:setString( text )
    
    local function onClose(sender,eventType)
        if  eventType == ccui.TouchEventType.ended then
            
            if func_callBack_close then
                func_callBack_close()
            end
            
            local targetPlatform = cc.Application:getInstance():getTargetPlatform()
            --if (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform)  then
            local ok, ret =  LuaObjcBridge.callStaticMethod("AppController", "exitGame" ,  { } )
            --end
            
            --startLoading();
            _widget:removeFromParent();
            _widget = nil;
            
        end
    end
    
    
    local button = _widget:getChildByName("Button_Sure")
    button:addTouchEventListener(onClose)
    
    if sure_text then
        button:getChildByName("Button_Sure_Text"):setString(sure_text)
    end
    
    
    if func_callBack_confirm_with_cancel then
        
        local function onConfirm (sender,eventType)
            if  eventType == ccui.TouchEventType.ended then
                
                mylib.selfRemove( _widget )
                
                if func_callBack_confirm_with_cancel then
                    func_callBack_confirm_with_cancel()
                end
                
                
            end
        end
        
        local button_confirm = button:clone()
        button_confirm:addTouchEventListener(onConfirm)
        
        button:getParent():addChild( button_confirm )
        
        
        button:getChildByName("Button_Sure_Text"):setString(require("gameText").getGameText("ID_TEXT_ASSETSDOWNLOAD_015"))
        
        
        
        local margin = 6
        button:setPosition(  cc.p( button:getParent():getContentSize().width/2 -  button:getContentSize().width/2 - margin   , button:getPositionY()  )  )
        button_confirm:setPosition(  cc.p( button:getParent():getContentSize().width/2 +  button:getContentSize().width/2 + margin   , button:getPositionY()  )  )
    end



    cc.Director:getInstance():getRunningScene():addChild(_widget, 10)
end


local function checkDownloadAsset()
    
    --增量更新出错 处理
    local function increUpdateError( err_log )
        --删除 asset des 文件
        
        local assetsDownLoad = require("assetsDownLoad")
        
        local path = CCFileUtils:getInstance():getWritablePath( ) .. assetsDownLoad.download_file_folder .. "/asset_check_" .. CLIENT_BASE_VERSION
        os.remove(path)
        
        
        
        local function exitGame()
            --清除下载的资源版本
            local assetsDownLoad = require("assetsDownLoad")
            assetsDownLoad.deleteAssetsVersion()
            
            local targetPlatform = cc.Application:getInstance():getTargetPlatform()
            --if (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform)  then
            local ok, ret =  LuaObjcBridge.callStaticMethod("AppController", "exitGame" ,  { } )
            --end
        end
        
        local function continueDownload()
            local assetsDownLoad = require("assetsDownLoad")
            local scene = assetsDownLoad:create()
            cc.Director:getInstance():replaceScene(scene )
        end
        
        mylib:callLater( function() showAlert( require("gameText").getGameText("ID_TEXT_SCENELAUNCHLOAING_012") .. ( err_log or "" ) , exitGame , continueDownload ) end   , 0.2 )
        
        print( " increUpdate Error 文件下载错误" )
        
    end
    
    local function checkAllUpdateFile( dl_file_md5_check_dict , bNormalFile )
        flag_dl_wrong_version_file = false
        local error_log = ""
        --所有需要比较的文件，做md5 校验
        for path, check in pairs( dl_file_md5_check_dict  ) do
            
            if true then --not string.find( path , ".plist" ) then
                
                _path = path
                local path = CCFileUtils:getInstance():fullPathForFilename( path )
                
                --print(path , _path )
                
                local data = nil
                
                if cTools.getBase64File then
                    print ( "使用 cTools.getBase64File " )
                    
                    data = cTools:getBase64File( path )
                    if bNormalFile then
                        local mime = require("mime")
                        data = mime.unb64( data )
                    end
                    else
                    print ( "使用 md5" )
                    
                    local f = io.open(path, "r")
                    if f then
                        data = f:read("*all")
                        f:close()
                        
                        if not bNormalFile then
                            local mime = require("mime")
                            local md5 =require 'md5'
                            data = mime.b64( data )
                        end
                    end
                end
                
                
                
                
                if data then
                    local md5 =require 'md5'
                    local md5_val  = md5 . sumhexa ( data )
                    
                    print ( "md5 比较" ,   _path , md5_val , check )
                    if md5_val ~= check then
                        print("!!!下载的文件 md5 码不对" ,  _path ,  md5_val , check )
                        flag_dl_wrong_version_file = true
                        
                        error_log = require("gameText").getGameText("ID_TEXT_SCENELAUNCHLOAING_013") .. _path
                    end
                else
                    print("!!!校验的文件不存在" ,  _path )
                    
                    flag_dl_wrong_version_file = true
                    
                    error_log = require("gameText").getGameText("ID_TEXT_SCENELAUNCHLOAING_014") .. _path
                end
                
            end --no plist
        end
        
        return flag_dl_wrong_version_file , error_log
    end
    
    --开始校验
    
    local assetsDownLoad = require("assetsDownLoad")
    -- checkAsset and checkAsset_plus 是从服务器拉下来的md5 描述文件中的数据
    
    print( "检验开始:" ,  last_assets_checkSum , checkAsset , checkAsset_plus )
    if last_assets_checkSum > 0 and checkAsset and checkAsset_plus then
        local flag_dl_wrong_version_file = false
        local dl_file_md5_check_dict = {}
        
        
        
        --找出所有需要更新的文件
        for k, v in pairs(checkAsset) do
            local localAsset = last_assets_localAsset  
            if localAsset[ v.path] == nil or localAsset[ v.path].check ~= v.check then
                
                local index = k
                --校验md5, 3个 资源包除外
                if string.find( checkAsset[index].path , "zip_data" ) == nil
                    and string.find( checkAsset[index].path , "zip_pb" ) == nil
                    and string.find( checkAsset[index].path , "zip_lua" ) == nil then
                    
                    dl_file_md5_check_dict[  checkAsset[index].path ] = checkAsset[index].check
                    print( "增加校验文件:" ,  checkAsset[index].path )
                end
            end
        end
        
        
        
        flag_dl_wrong_version_file , err  = checkAllUpdateFile( dl_file_md5_check_dict , true )
        
        if flag_dl_wrong_version_file then
            increUpdateError( err )
            return false
        end
        
    end
    
    
    print( "checkAsset_plus1 : " , checkAsset_plus )
    if not checkAsset_plus then
        
        local path = CCFileUtils:getInstance():getWritablePath( ) .. assetsDownLoad.download_file_folder .. "/asset_check_" .. CLIENT_BASE_VERSION
        local f = io.open(path, "r")
        if f then
            local data = f:read("*all")
            f:close()
            
            if data then
                loadstring(data)()
            end
        end
    end
    
    
    print( "checkAsset_plus2 : " , checkAsset_plus )
    if checkAsset_plus then
        local assetsDownLoad = require("assetsDownLoad")
        local path = CCFileUtils:getInstance():getWritablePath( ) .. assetsDownLoad.download_file_folder .. "/asset_check_" .. CLIENT_BASE_VERSION
        
        --已经下载过更新
        if cc.FileUtils:getInstance():isFileExist( path ) then
            
            print( "assetsDownLoad file exist  "  )
            
            
            --常规校验，没有下载更新的情况下
            local flag_dl_wrong_version_file = false
            local dl_file_md5_check_dict = {}
            
            --local exclude_list = {  "mylib" , "Cocos2d" ,  "assetsDownLoad"  }
            
            --找出 3个资源包中，需要校验的文件
            for i, v in ipairs( checkAsset_plus  ) do
                dl_file_md5_check_dict[v.path] = v.check
            end
            
            flag_dl_wrong_version_file , err  = checkAllUpdateFile( dl_file_md5_check_dict )
            
            if flag_dl_wrong_version_file then
                increUpdateError(  err )
                return false
            end
        end
    end
    
    checkAsset = nil
    checkAsset_plus = nil
    
    
    --[[
    --测试
    increUpdateError( require("gameText").getGameText("ID_TEXT_SCENELAUNCHLOAING_015"))
    
    if true then
        return false
    end
    --]]
    
    --校验结束
    
    return true
end


local function reloadModule( moduleName )
    package.loaded[moduleName] = nil
    return require(moduleName)
end

function create(  )
    
    print( " new sceneLauchLoading" )
    
    --clear file path cache
    cc.FileUtils:getInstance():purgeCachedEntries()
    
    local assetsDownLoad = require("assetsDownLoad")
    last_assets_checkSum = assetsDownLoad.checkSum
    last_assets_localAsset = assetsDownLoad.localAsset
    
    assetsDownLoad = reloadModule( "assetsDownLoad" )
    mylib = reloadModule( "mylib" )
    Cocos2d = reloadModule( "Cocos2d" )
    
    _G .assetsDownLoad = assetsDownLoad
    _G .mylib = mylib
    _G .Cocos2d = Cocos2d
    
    
    --设置路径 4 校验
    local pathToSave = CCFileUtils:getInstance():getWritablePath() .. assetsDownLoad.download_file_folder
    local search_paths = {
        pathToSave , ""
    }
    CCFileUtils:getInstance():setSearchPaths( search_paths  )
    
    
    
    
    --检验错误，重新下载
    if not checkDownloadAsset() then
        --重新下载
        assetsDownLoad.changeBackupDownloadServerIP()
        
        --停止跳转
        --1.0
        return cc.Scene:create()
    end
    
    
    
    --重新设置路径
    
    
    
    
    local pathTmp  = CCFileUtils:getInstance():getWritablePath() .. "tmp/"
    
    local pathImgMissing = CCFileUtils:getInstance():getWritablePath() .. assetsDownLoad.download_file_folder .. "/cocostudio_images_missing/"
    local pathImgNew  = CCFileUtils:getInstance():getWritablePath() .. assetsDownLoad.download_file_folder .. "/cocostudio_images_new/"
    
    --[[
     英文:         UI_Resources_EN
     台湾繁体:  UI_Resources_TRADI
     香港繁体:  UI_Resources_HK
    --]]
    local search_paths = {
        pathToSave , pathImgNew ,  pathImgMissing , "" , pathTmp , "cocostudio_images_new/" , "cocostudio_images_missing/"
    }
    CCFileUtils:getInstance():setSearchPaths( search_paths  )
    
    
    -- 添加繁体版路径
    --[ [
    local game_config = reloadModule( "game_config" )
    
    --默认台湾繁体
    if game_config.bIS_TRADITIONAL_VERSION then
        local path_multi_lang = "UI_Resources_TRADI/"
        table.insert( search_paths , 1 , pathToSave .. "/" .. path_multi_lang  )
        table.insert( search_paths , #search_paths -3 , path_multi_lang   )
    end
    CCFileUtils:getInstance():setSearchPaths( search_paths  )
    --]]
    
                                             
     for i,v in ipairs(  CCFileUtils:getInstance():getSearchPaths() ) do
         
         print("search path b4 special version:" , i, string.format("-%s-" , v ))
     end
    --设置路径结束
    
    
    
                                             
                                             
    

    
    
    --因为增量更新的bug， sceneLogo 没有播放过
    if (not sceneLogo)  then
        CCLOG("patch: 播放logo 动画")
        
        local sceneLogo= require("sceneLogo")
        local scene = sceneLogo:create()
        
        return scene
    end
    
    
    
    --对下载内容进行检查
    scriptEntry = cc.Director:getInstance():getScheduler():scheduleScriptFunc( swith2NextScene , 0.1, false)
    

    local targetPlatform = cc.Application:getInstance():getTargetPlatform()

    local folder_cocostudio_images_new = -1
    for i,v in ipairs(  CCFileUtils:getInstance():getSearchPaths() ) do
        --print ( "find path" , i, v , ((targetPlatform == cc.PLATFORM_OS_ANDROID) and  "assets/" or "" ) )
        if v == ( targetPlatform == cc.PLATFORM_OS_ANDROID  and  "assets/" or "" ) then
            folder_cocostudio_images_new = i
        end
    end


    local game_config = reloadModule("game_config")
    if folder_cocostudio_images_new > 0 and game_config.IS_XMAS_VERSION then
        CCLOG("add xmas folder ")
        local searchPaths = CCFileUtils:getInstance():getSearchPaths()
        
        --TODO chech whether we need show XMAS content
        local path = "XMAS_res_all/"
        table.insert( searchPaths , folder_cocostudio_images_new , path )
        
        local path = "XMAS_Resources/"
        table.insert( searchPaths , folder_cocostudio_images_new , path )
        
        
        
        local path = CCFileUtils:getInstance():getWritablePath() .. assetsDownLoad.download_file_folder ..  "/XMAS_res_all/"
        table.insert( searchPaths , 1 , path )
        
        local path = CCFileUtils:getInstance():getWritablePath() .. assetsDownLoad.download_file_folder ..  "/XMAS_Resources/"
        table.insert( searchPaths , 1 , path )
        
        
        
        CCFileUtils:getInstance():setSearchPaths( searchPaths )
        
    elseif folder_cocostudio_images_new > 0 and (game_config.IS_NEWYEAR_VERSION  or  game_config.IS_LANTERN_VERSION )then
        CCLOG("add new year folder ")
        local searchPaths = CCFileUtils:getInstance():getSearchPaths()
        
        --TODO chech whether we need show XMAS content
        local path = "NewYear_res_all/"
        table.insert( searchPaths , folder_cocostudio_images_new , path )
        
        local path = "NewYear_Resources/"
        table.insert( searchPaths , folder_cocostudio_images_new , path )
        
        
        
        local path = CCFileUtils:getInstance():getWritablePath() .. assetsDownLoad.download_file_folder ..  "/NewYear_res_all/"
        table.insert( searchPaths , 1 , path )
        
        local path = CCFileUtils:getInstance():getWritablePath() .. assetsDownLoad.download_file_folder ..  "/NewYear_Resources/"
        table.insert( searchPaths , 1 , path )
        
        
        
        CCFileUtils:getInstance():setSearchPaths( searchPaths )
    end

    for i,v in ipairs(  CCFileUtils:getInstance():getSearchPaths() ) do
        
        print("search path after special version:" , i, string.format("-%s-" , v ))
    end

    --重要，路径设置之前，必须保证 global_data 之类的 module 没有被载入
    if  global_data   then
        print ( 1 > nil  )
    end

    --第三版加入的代码，应该在 增量更新结束后，再执行一遍===============================================================
    if not cTools:isDebugVersion() then
        --release version
        print = function(   ) end

        cTools.showTimeConsume = function(   ) end

        CCLOG = function() end

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


    --reload mylib
    reloadModule("mylib")
    reloadModule("Cocos2d")
    reloadModule("json")

    --重新载入文本
    reloadModule("gameText")

    --必须等路径设置完毕，再导入其他module
    local cShader = require("cShader")

    --默认台湾繁体
    local global_data = require( "global_data" )
    if game_config.bIS_TRADITIONAL_VERSION then
        global_data.setLanguage( game_config.CUR_LANG )
    end


    local loading_layer =  cc.Layer:create() -- mylib:addLoadingInfoLayer()
    --[ [
    local winSize = cc.Director:getInstance():getWinSize();
    local bgSpt = ccui.ImageView:create("Login-Background-ip.png");
    bgSpt:setPosition(cc.p(winSize.width/2, winSize.height/2));
    loading_layer:addChild(bgSpt);
    --]]
    local scene = cc.Scene:create()
    scene:addChild( loading_layer )


    return scene
end

--1.0版本，在下载路径正确设置前，很多module和数据文件都已经被错误的载入，
--导致 数据文件不能更新到最新
--这个变量用来判断，是否需要执行临时补丁
VER_1_MODULE_LOAD_BUG_FIXED = true


return sceneLaunchLoaing
