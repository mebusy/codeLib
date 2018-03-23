--[[
常用的方法库 
--]]

--here, define global function
require "Cocos2d"


CCLOG = function(formatstring,...)
	local ret1,ret2 = pcall(string.format,formatstring,...)
	if(ret1)then
		print(ret2)
	else
		print("lua CCLOG error :",ret2)
	end
end


if (not cTools:isDebugVersion() )
    --or (cc.PLATFORM_OS_ANDROID == cc.Application:getInstance():getTargetPlatform())
    
    then
    CCLOG = function() end
end


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
    else
        require("mylib"):showAlert(tostring(msg))
    end
    --]]
    
end


function cc.pTruncate( vec, maxVal)
    local length = cc.pGetLength( vec )
    if length <= maxVal then
        return vec
    else
        return cc.pMul( vec ,  maxVal/length )
    end
end


--字符串处理扩展,只有分隔符前后有实际意义的字符，才会处理
string.split = function( s, p )
    local rt= {}
    string.gsub(s, '[^'..p..']+', function(w) table.insert(rt, w) end )
    return rt
end

string.lastComponent = function(  s )
    local list = string.split(s, '.')

    return list[#list]
end

string.firstComponent = function( s )
    local list = string.split(s, '.')

    return list[1]
end

-- table list
table.index = function ( t , element )
    for i , ele in ipairs (t) do
        if ele == element then
            return i
        end
    end
    return -1
end

-- here , is package mylib

local P = {}
mylib = P

--declear everything this package needs from outside
--local sqrt = math.sqrt
--local io = io

local _G = _G

-- no more external access after this point
setmetatable(P, {__index = _G})
setfenv(1, P)


redColor = cc.c3b(230,80,80)
greenColor = cc.c3b(80,230,80)

--计算算数表达式值
--使用 class:func_name 方式定义的，可以省略 eval
function eval( self, str)
    
    if type(str) == "string" then
        return loadstring("return " .. str)()
        elseif type(str) == "number" then
        return loadstring("return " .. tostring(str))()
        else
        error("is not a string")
    end
end


--服务器时区
--TODO 国际服，需要修改，要和服务器时区保持一致
SERVER_TIME_ZONE = 8

--获取本地时区
local function get_timezone()
    local now = os.time()
    return math.floor( (os.difftime(now, os.time(os.date("!*t", now))) + 10) /60/60 )
end

--usage: year , month, day , hour, min , sec = mylib.getServerTime()
--delta_time : 可选参数，如果delta_time_sec 不为nil， 则时间往后延 delta_time_sec 秒
function getServerTime( delta_time_sec )
    local format_date = os.date("!%Y %m %d %H %M %S" , os.time( ) + SERVER_TIME_ZONE* 60*60 + (delta_time_sec or 0) )
    local dates = string.split( format_date , " " )
    local year , month, day , hour, min , sec =  dates[1] ,dates[2] ,dates[3] ,dates[4] ,dates[5] ,dates[6]
    
    return  tonumber( year) , tonumber(month) , tonumber(day)  , tonumber(hour) , tonumber(min)  , tonumber(sec)
end

print ("服务器时间:" , getServerTime() )


--两个日期是否同一天
function isSameDay( time1 , time2 )
    local day1 = os.date("!%d" , time1 + mylib.SERVER_TIME_ZONE* 60*60 )
    local day2 = os.date("!%d" , time2 + mylib.SERVER_TIME_ZONE* 60*60 )
    
    return day1==day2
end



--点到直线距离
function distPoint2DLine( self, pt ,  line_from ,line_to   )
    if line_from.x == line_to.x and line_from.y == line_to.y then
        return 9999999999
    end
    
    local vec = cc.pSub( line_from ,line_to )
    local vec_pt = cc.pSub( pt ,line_to )
    
    local cross = cc.pCross( vec_pt,   vec  )
    
    local dist = math.abs( cross / cc.pGetLength( vec ))
    
    return dist
end

--点到线段距离
function distPoint2Line( self, c ,  a , b     )   --pt ,  line_from ,line_to
    local pt ,  line_from ,line_to  = c ,  a , b
    
    if line_from.x == line_to.x and line_from.y == line_to.y then
        return 9999999999
    end
    
    
    
    local ab = cc.pSub( b , a)
    local ac = cc.pSub( c , a)
    
    if cc.pDot(ab,ac) <=0 then
        local dist =  cc.pGetLength( ac )
        return dist
        
    end
    
    
    local ba = cc.pSub( a, b )
    local bc = cc.pSub( c, b )
    
    if cc.pDot(ba,bc) <=0 then
        local dist =  cc.pGetLength( bc )
        return dist
    end
    
    
    local vec = cc.pSub( line_from ,line_to )
    local vec_pt = cc.pSub( pt ,line_to )
    
    local cross = cc.pCross( vec_pt,   vec  )
    
    local dist = math.abs( cross / cc.pGetLength( vec ))
    
    return dist
end

--点到线段距离, 必须具有 ab 穿透c的效果
function distPoint2LinePenatrate( self, c ,  a , b     )   --pt ,  line_from ,line_to
    local pt ,  line_from ,line_to  = c ,  a , b
    
    if line_from.x == line_to.x and line_from.y == line_to.y then
        return 9999999999
    end
    
    
    
    local ab = cc.pSub( b , a)
    local ac = cc.pSub( c , a)
    
    if cc.pDot(ab,ac) <=0 then
        return 9999999999
        
    end
    
    
    local ba = cc.pSub( a, b )
    local bc = cc.pSub( c, b )
    
    if cc.pDot(ba,bc) <=0 then
        return 9999999999
    end
    
    --570.451541,-111.775930   502.593974,-276.451484  541.530462,-285.156980
    
    local vec = cc.pSub( line_from ,line_to )
    local vec_pt = cc.pSub( pt ,line_to )
    
    local cross = cc.pCross( vec_pt,   vec  )
    
    local dist = math.abs( cross / cc.pGetLength( vec ))
    
    if dist <= cBall.DISTANCE_TO_PICK then
        --CCLOG( "3 %f,%f   %f,%f  %f,%f  - %d" , c.x, c.y, a.x,a.y, b.x,b.y  , dist   )
    end
    
    return dist
end

--遍历table
function traverse_table ( self, t , indent)
    indent = indent or ""
    print (indent , "{")
    for key, value in pairs ( t ) do
        if type(value) == "table" then
            print ( indent , "\t" , key , ": " , value )
            traverse_table( self ,  value ,  indent , "\t" )
        else
            print ( indent , "\t" , key , ": " , value   )
        end
    end
    print ( indent , "}")
end

-- CCNode 从父节点上删除，并清理自己
-- 注意这不是对象调用的方式
function selfRemove( sender )
    sender:removeFromParent( true )
    CCLOG(  "removed & cleanup"     )
end

function cleanMemory()
    --容易出错
    --cc.SpriteFrameCache:getInstance():removeUnusedSpriteFrames()
    cc.Director:getInstance():getTextureCache():removeUnusedTextures()
end

function notificationNode( self )
    local notification_node = cc.Director:getInstance():getNotificationNode()
    
    if notification_node == nil then
        CCLOG("create notification node .")
        local node = cc.Node:create()
        cc.Director:getInstance():setNotificationNode( node)
        node:onEnter()
        
        notification_node = cc.Director:getInstance():getNotificationNode()
    end
    
    
    return notification_node
end

--================== blend ==========================
blend_normal = {}
blend_normal.src = GL_SRC_ALPHA
blend_normal.dst = GL_ONE_MINUS_SRC_ALPHA

blend_sub = {}
blend_sub.src = GL_ZERO
blend_sub.dst = GL_ONE_MINUS_SRC_COLOR

blend_add = {}
blend_add.src = GL_SRC_ALPHA
blend_add.dst = GL_ONE



function adsID ()
    local targetPlatform = cc.Application:getInstance():getTargetPlatform()
    if (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform)  then
        local ok, ret =  LuaObjcBridge.callStaticMethod("AppController", "adsID" ,  {  } )
        --print( ok, ret )
        if ok then
            return ret
        end
    else
    
        
    end
    
    return "unknown udid"
end

function versionBuildTime ()
    local targetPlatform = cc.Application:getInstance():getTargetPlatform()
    if (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform)  then
        local ok, ret =  LuaObjcBridge.callStaticMethod("AppController", "versionBuildTime" ,  {  } )
        --print( ok, ret )
        if ok then
            return ret
        end
    else
        
        
    end
    
    return "unknown build time"
end


--创建一个sprite
--统一使用这个方法创建 sprite， 不要直接使用 cc.Sprite:create()
function createSprite( self, spriteName , spriteSheetName )

    if spriteSheetName == nil then
        return cc.Sprite:create( spriteName )
    else
        --TODO
        return nil
    end
    
    return nil
end


function updateNumericalLabel(self, label, new_number )
    
    local str_cd = "" .. math.ceil(new_number)
    if label:getString() ~= str_cd then
        --CCLOG("update skill %d 's cd: %s" ,  self.mSkill_id ,   str_cd )
        label:setString( str_cd )
    end
end

--text_aligment  : 默认 visibleSize.width
--line_maxWidth  : 默认 cc.TEXT_ALIGNMENT_CENTER
--注意: Outline TTF 不能使用 setScale, 否则会出现多余的笔画
function LabelOutline(self  , text  , fontSize, color3b, outlineColor4b , text_aligment , line_maxWidth     )
    --[[
     local game_config = require("game_config")
    
     
    local ttfConfig = {}
    ttfConfig.fontFilePath = game_config.GAME_FONT
    
    --固定 font size 和 outlise size , 避免创建过多的 font atlas
    ttfConfig.fontSize = fontSize
    ttfConfig.glyphs   = cc.GLYPHCOLLECTION_DYNAMIC
    ttfConfig.customGlyphs = nil
    --ttfConfig.distanceFieldEnabled = true
    --ttfConfig.outlineSize = 1 --math.floor((fontSize/8))
    --
     
    line_maxWidth = line_maxWidth or visibleSize.width
    
    text_aligment = text_aligment or cc.TEXT_ALIGNMENT_CENTER
    
    local label3 = cc.Label:createWithTTF(ttfConfig,  text ,text_aligment, line_maxWidth )
    --label3:setPosition( cc.p(s.width/2, s.height * 0.48))
    label3:setColor( color3b )
    label3:setAnchorPoint(cc.p(0.5, 0.5))
    --label3:enableOutline( outlineColor4b )
    --const Color4B& shadowColor /* = Color4B::BLACK */,const Size &offset /* = Size(2 ,-2)*/, int blurRadius /* = 0 */
    label3:enableShadow( outlineColor4b , cc.size(4,-4), 0.5  )
    --]]
    
    --[ [
    local outlineColor3b = cc.c3b( outlineColor4b.r , outlineColor4b.g, outlineColor4b.b )
    
    local label3 =   cc.Label:createWithTTF(text  , game_config.GAME_FONT , fontSize )
    --label3:enableStroke( cc.c3b(0,0,0) ,  math.floor( fontSize/( bBold and 6 or 8 ) ) , true  )
    
    label3:setColor( color3b )
    
    --const Size &shadowOffset, float shadowOpacity, float shadowBlur, bool updateTexture
    local shadowDensity = math.max(1, math.floor(fontSize/40) )
    label3:enableShadow( outlineColor4b , cc.size(shadowDensity,-shadowDensity), 0.5  )
    --]]
    return label3
end




function coverWidgetWith( self,  ori_obj, rep_obj )
    
    if rep_obj ~= nil then
        
        --排序
        local all_child = ori_obj:getParent():getChildren()
        for i, node in ipairs( all_child ) do
            local z = node:getLocalZOrder()
            
            if z== 0 then
                node:setLocalZOrder( i*10)
            end
            --[[
            if node.getName ~= nil then
                print (i, node:getName() , node:getLocalZOrder() )
            end
            --]]
        end
        --记录需要替换node的 zorder
        local z = ori_obj:getLocalZOrder()
        ori_obj:setVisible(false)
        
        rep_obj:setAnchorPoint( ori_obj:getAnchorPoint() )
        rep_obj:setPosition( cc.p( ori_obj:getPositionX(), ori_obj:getPositionY()  ) )
        
        if rep_obj.setFlippedX then
            rep_obj:setFlippedX( ori_obj:isFlippedX() )
            rep_obj:setFlippedY( ori_obj:isFlippedY() )
        end
        
        --print ( ori_obj:getRotation() )
        rep_obj:setRotation( ori_obj:getRotation() )
        
        --print( 'new z-order' ,  z )
        ori_obj:getParent():addChild( rep_obj , z )
    
    end
end



--net work




-- cocos UI related

function switch2NormalDesign()

end
function switch2RetinaDesign()

end

--[[
 
 4   109,42
 145x74
 
 
 6
 145x45
 145x39
 
 
 
 4  142x44
 
 
--]]
function addFX2Widget( self, widget )
    
    --不要过早添加按钮效果
    if not global_data then
        return
    end
    
    
    local cFX = require("cFX")
    local all_child = widget:getChildren()
    for i, node in ipairs( all_child ) do
        
        if not node.bFXAdded then
            node.bFXAdded  = true
            
            --print( tolua.type(node) )
            if node.isTouchEnabled and node:isTouchEnabled()
                and  (tolua.type(node) == "ccui.Button" or tolua.type(node) == "ccui.ImageView" ) then
                
                if --[[(
                    
                    node:getContentSize().width == 145 and
                    (node:getContentSize().height == 45 or node:getContentSize().height == 39 ) )
                    
                    or--]]
                    ( node:getContentSize().width == 146 and  node:getContentSize().height == 48  )
                    --or ( node:getContentSize().width == 225 and  node:getContentSize().height == 78  )
                    
                    then
                    
                    local fx = cFX.createButtonNormal1()
                    fx:setPosition( cc.p( node:getContentSize().width/2 ,  node:getContentSize().height/2   ) )
                    node:addChild( fx )
                end
                
                --[[
                if (node:getContentSize().width == 145 and  node:getContentSize().height == 74 )then
                    
                    local fx = cFX.createButtonNormal2()
                    fx:setPosition( cc.p( node:getContentSize().width/2 ,  node:getContentSize().height/2   ) )
                    node:addChild( fx )
                    
                end
                --]]
                if (node:getContentSize().width == 109 and  node:getContentSize().height == 42 )then
                    
                    local fx = cFX.createButtonNormal2()
                    fx:setPosition( cc.p( node:getContentSize().width/2 ,  node:getContentSize().height/2   ) )
                    node:addChild( fx )
                end
                
                if (node:getContentSize().width == 142 and  node:getContentSize().height == 44 )then
                    
                    local fx = cFX.createButtonSanguo()
                    fx:setPosition( cc.p( node:getContentSize().width/2 ,  node:getContentSize().height/2   ) )
                    node:addChild( fx )
                end
                
            end
            
            mylib:addFX2Widget( node )
            
        end -- end not node.bFXAdded
    
        
    end -- end for
    
end

function recursiveSetWidgetShader( self ,  widget , shader_name )
    
    if widget.getVirtualRenderer and widget:getVirtualRenderer()~=nil and "ccui.Text"~= tolua.type( widget ) then
        widget:getVirtualRenderer():setGLProgramState( cc.GLProgramState:getOrCreateWithGLProgramName( shader_name ) )
    end
    
    local all_child = widget:getChildren()
    for i, node in ipairs( all_child ) do
        if node.getVirtualRenderer and node:getVirtualRenderer()~=nil and "ccui.Text"~= tolua.type( node ) then
            node:getVirtualRenderer():setGLProgramState( cc.GLProgramState:getOrCreateWithGLProgramName( shader_name ) )
        end
        mylib:recursiveSetWidgetShader( node , shader_name )
    end -- end for
end

function clippingcircleShader(icon,shader_name)
    if global_data.training_mask == nil then
        global_data.training_mask = cc.Director:getInstance():getTextureCache():addImage( 'TrainMask.png' )
        global_data.training_mask:retain()
    end

    icon:getVirtualRenderer():setGLProgramState( cc.GLProgramState:getOrCreateWithGLProgramName( shader_name ) )
    icon:getVirtualRenderer():setTexture2(global_data.training_mask)
    
end

function recursiveSetWidgetOpacity( self ,  widget , opacity )
    if widget.setOpacity  then
        widget:setOpacity( opacity )
    end
    
    local all_child = widget:getChildren()
    for i, node in ipairs( all_child ) do
        if node.setOpacity  then
            node:setOpacity( opacity )
        end
        mylib:recursiveSetWidgetOpacity( node , opacity  )
    end -- end for
end


-- 界面居中
function setUI2Center( self, _widget )
    
    _widget:setAnchorPoint( cc.p( 0.5, 0.5 ) )
    _widget:setPosition( cc.p( origin.x + visibleSize.width/2, origin.y + visibleSize.height/2 ) )
    
    mylib:addFX2Widget(_widget)
end

--组件对齐右下角
function alignWidget2RightBottom(self, size,  w )
    w:setAnchorPoint( cc.p( 1, 0 ))
    w:setPosition( cc.p( size.width/2 + visibleSize.width/2 , size.height/2 - visibleSize.height/2 ) )

end

function alignWidget2LeftBottom(self, size,  w )
    w:setAnchorPoint( cc.p( 0, 0 ))
    w:setPosition( cc.p( size.width/2 - visibleSize.width/2  , size.height/2 - visibleSize.height/2   ) )
end

function alignWidget2RightTop(self, size,  w )
    w:setAnchorPoint( cc.p( 1,1 ))
    w:setPosition( cc.p( size.width/2 + visibleSize.width/2 , size.height/2 + visibleSize.height/2 )  )
end

function alignWidget2LeftTop(self, size,  w )
    w:setAnchorPoint( cc.p( 0,1 ))
    w:setPosition( cc.p( size.width/2 - visibleSize.width/2 , size.height/2 + visibleSize.height/2 ) )
end


--如果必要，对ipad等某些 屏幕长宽比过小的设备， 缩小 UI 显示
function keepAspectRatio(self ,w)
    local normal_ratio = game_config.DESIGN_RESOLUTION_WIDTH / game_config.DESIGN_RESOLUTION_HEIGHT
    local cur_ratio = visibleSize.width / visibleSize.height
    --example : ipad
    if cur_ratio  <  normal_ratio then
        CCLOG("aspect ratio changed: %f - %f" , cur_ratio  ,  normal_ratio )
        w:setScale(  w:getScaleX() * cur_ratio/normal_ratio )
    end
end


function autoScaleWidget4DifferentResolution( self, widget )
    
    local bRetinaRes = widget:getLayoutSize().height > 700
    
    local dr_size = cc.Director:getInstance():getOpenGLView():getDesignResolutionSize()
    local scale = dr_size.height == game_config.DESIGN_RESOLUTION_HEIGHT and (bRetinaRes and 0.4 or 1) or (bRetinaRes and 0.8 or 2)
    widget:setScale(scale  )
    mylib:setUI2Center(widget)
    
    --print( "autoScaleWidget4DifferentResolution" ,widget:getLayoutSize().height ,  dr_size.height , scale )
end
--=====


--注意，showLoadingAnim 创建的node 不会自动删除
local function showLoadingAnim( parent )
    
    
    
    function startLoadingAnim(  parent , pos,  name_json, name_atals , init_anim_name   )
        
        --这里，不做缩放处理
        local  skeleton = sp.SkeletonAnimation:create(  name_json, name_atals , game_config.ANIM_SIZE_SCALE )
        --不需要自我删除的，可以自动更新
        skeleton:setManuelUpdate(false)
        
        skeleton:setPosition( pos )
        parent:addChild( skeleton )
        
        skeleton:setAnimation( 0, init_anim_name, true )
        
    end
    
    
    
    local node = cc.Node:create()
    parent:addChild( node   )
    
    local cUserData = require("cUserData")
    local cFX = require("cFX")
    local SceneManager = require("SceneManager")
    local result = SceneManager:getKeepData("UserInfoRes")
    
    local img_rep = "nbaloading.png"
    
    if result then
        img_rep = string.format("NBA-Newbie-LOGO-%d-ip.png" ,  cUserData.nba_team_id )
    end
    
    local atlas_file = cFX.createAtlasFile("spine_loading.atlas", "NBA-Newbie-LOGO-1-ip", img_rep )
    startLoadingAnim( node ,  cc.p( origin.x + visibleSize.width/2,  origin.y + visibleSize.height/2 )  ,
                     "spine_loading.json", atlas_file  , "diedao"   )
                     
                     
end

function addLoadingInfoLayer()
    local cUIBaseLayer = require("cUIBaseLayer")
    local loading_layer  = cUIBaseLayer:create( cc.c4b(0,0,0,255) )
    --[[防沉迷文字
    local text_warning = cc.Sprite:create( "text_warning.png" )
    text_warning:setAnchorPoint(cc.p( 0.5, 0 ))
    text_warning:setPosition( cc.p( origin.x + visibleSize.width/2 , origin.y   ) 
    loading_layer:addChild( text_warning )
    ]]
    --改为随机生成小贴士by dxy
    math.randomseed(tostring(os.time()):reverse():sub(1,6))
    local global_data = require("global_data")
    local tip_table = global_data.all_data[global_data.DATA.loadingtips]
    local counter = 0
    for var in pairs(tip_table) do
        counter = counter + 1
    end
    local rand = math.random(counter)
    print("tablesize = ",counter)
    print("rand = ",rand)
    local selected = tip_table[tostring(rand)].desc
    local text_tips = cc.Label:createWithTTF(selected,game_config.GAME_FONT,25)
    text_tips:setAnchorPoint(cc.p(0.5,0.5))
    text_tips:setColor(cc.c3b(255,255,255))
    text_tips:setPosition(cc.p( origin.x + visibleSize.width/2 , origin.y + 50 ))
    text_tips:setHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
    loading_layer:addChild( text_tips )
    
    
    local soundManager = require("soundManager")
    soundManager.playBackgroundMusic( "NBAYX-Loading.mp3"  )
    
    showLoadingAnim( loading_layer )
    
    return loading_layer
end


function callLater( self, func, time , str_debug , param)
    CCLOG( "callLater  %s" , str_debug or "")
    local scriptEntry
    local function callBack( )
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(scriptEntry)
        func( param )
    end
    
    scriptEntry = cc.Director:getInstance():getScheduler():scheduleScriptFunc( callBack , time , false)
    
end

--[[
 如果 func_callBack_confirm_with_cancel 不为 nil
 会自动扩展为 双按钮  require("gameText").getGameText("ID_TEXT_ASSETSDOWNLOAD_015") , require("gameText").getGameText("ID_TEXT_CALERTLAYER_001") 提示框
 --]]

function showAlert( self, alertText , func_callBack , func_callBack_confirm_with_cancel  ,default_color,sure_text  , cancel_text , checkBox_info , text_alignment  )
    
    --local ok, ret =  LuaObjcBridge.callStaticMethod("AppController", "showAlert" ,  {text = alertText  } )
    local cAlertLayer = require("cAlertLayer")
    cAlertLayer.showAlert(  alertText , func_callBack , func_callBack_confirm_with_cancel , default_color,sure_text  , cancel_text , checkBox_info , text_alignment )
end



function convertNormalString2AtlasText(self, atlas ,  normalString )
    local new_str_pos = ""
    for i = 1, string.len( normalString  ) do
        local index = string.find(  atlas , string.sub( normalString, i,i   ) )
        if index ~=nil then
            new_str_pos = new_str_pos .. string.char(48+index-1)
        end
    end
    
    return new_str_pos
    
end

function updateSliderManually( self, slider, listView  )
    local container = listView:getInnerContainer();
    local minDis = listView:getLayoutSize().height - container:getSize().height
    local posY = container:getPositionY();
    local percent = math.floor(100 * (minDis - posY) / minDis)
    slider:setPercent(percent)
    --print("slider 位置变更 " ,  percent , listView:getLayoutSize().height , container:getSize().height , posY  , eventType  )
end

function bindSlide2ScrollView( self, slider, listView, callback )
    
    local function sliderEvent(sender, eventType)
        if eventType == ccui.SliderEventType.percentChanged then
            listView:scrollToPercentVertical(sender:getPercent(), 0.1, false)
        end
    end
    
    -- 开启9宫，否则C++端会在static_cast<Scale9Sprite*>报错
    slider:setScale9Enabled(true)
    slider:addEventListenerSlider(sliderEvent)
    
    --print( slider:getContentSize().height , listView:getContentSize().height )
    --print( listView:getInnerContainerSize().height , slider:getContentSize().width, listView:getContentSize().height )
    --print(listView:getInnerContainerSize().height * slider:getContentSize().width/ listView:getContentSize().height)
    --print( slider:getContentSize().width , slider:getContentSize().height )
    --listView:getInnerContainerSize().height 
    print("listViewH", listView:getInnerContainerSize().height,listView:getInnerContainerSize().height  * slider:getContentSize().width/ listView:getContentSize().height )
    slider:useProgressBar( listView:getInnerContainerSize().height  * slider:getContentSize().width/ listView:getContentSize().height )
    
    local function listScrollEvent(sender, eventType)
        mylib:updateSliderManually(  slider, listView  )

        if callback ~= nil then
            callback(sender, eventType)
        end
    end
    
    listView:addEventListenerScrollView(listScrollEvent)
    
    
    
end


function lockButton( self, w )
    w:setTouchEnabled(false)
    w:setVisible(false)
    w:getVirtualRenderer():setGLProgramState( cc.GLProgramState:getOrCreateWithGLProgramName( "shader_gray" ) )
end
-- format: 设为alpha 是告诉 spine runtime
-- 这里处理为 non premultiply alpha
spine_atlas_template =
[[
%s
size: %d,%d
format: MARK_FOR_NON_PREMUL_ALPHA
filter: Linear,Linear
repeat: none
%s
  rotate: false
  xy: 0, 0
  size: %d, %d
  orig: %d, %d
  offset: 0, 0
  index: -1

]]


function checkCachedTexture()
    
    if not cTools:isDebugVersion() then
        return
    end
    
    CCLOG("checkCachedTexture")
    local s =  cc.Director:getInstance():getTextureCache():getCachedTextureInfo()
    
    local t  = {}
    local bLeak = false
    for text in string.gfind( s , '%D/([%-_%w]-.png)"' ) do
        if t[text] == nil then
            t[text] = 1
            
            --CCLOG( " %s in textureCache" , text )
        else
        
            bLeak = true
            print ("texture leak:"  , text)
        end
    end
    
    if bLeak then
        print( s )
        LuaObjcBridge.callStaticMethod("AppController", "showAlert" ,  {text = require("gameText").getGameText("ID_TEXT_MYLIB_002")  } )
    end
end


function preHandleNodeWidgetPlayerCenter ()
    
    local widget =  ccs.GUIReader:getInstance():widgetFromJsonFile("Players_Dormitory_Information_Player.json")
    widget:retain()
        --检查所有的 9scale image
    local function check9ScaleImage(  node , zorder_start_force  )
        local zorder_start = zorder_start_force or 0
        
        for i, v in ipairs( node:getChildren() ) do
            
            if tolua.type( v ) == "ccui.ImageView"  and v:isScale9Enabled() then
                local size = v:getContentSize()
                local w = size.width
                local h = size.height
                
                v:setVisible(true)
                v:setPosition( cc.p( w*v:getAnchorPoint().x , h*v:getAnchorPoint().y ) )
                
                local rt = cc.RenderTexture:create( w, h  )
                rt:beginWithClear(0,0,0,0)
                
                v:visit()
                rt:endToLua()
                
                local path = string.format( "tmp/NodeWidgetPlayerCenter_%d.png" , zorder_start )
                rt:saveToFile( path , cc.IMAGE_FORMAT_PNG )
                
            end
            
            v:setLocalZOrder( zorder_start )
            
            
            zorder_start = check9ScaleImage(  v , zorder_start+1  )
        end -- end for
        
        return zorder_start
        
    end --end func
    check9ScaleImage(  widget  )
end





local node_widget_PlayerCenter_
function getNodeWidgetPlayerCenter ()
    --加速加载
    if not node_widget_PlayerCenter_ then
        node_widget_PlayerCenter_ = ccs.GUIReader:getInstance():widgetFromJsonFile("Players_Dormitory_Information_Player.json")
        node_widget_PlayerCenter_:retain()
        
        --检查所有的 9scale image
        local function check9ScaleImage(  node , zorder_start_force  )
            local zorder_start = zorder_start_force or 0
            
            for i, v in ipairs( node:getChildren() ) do
                
                if tolua.type( v ) == "ccui.ImageView"  and v:isScale9Enabled() then
                    
                    local path = string.format( "NodeWidgetPlayerCenter_%d.png" , zorder_start )
                    
                    
                    local image = ccui.ImageView:create()
                    image:loadTexture(path )
                    
                    image:setPosition(cc.p( v:getPositionX() , v:getPositionY()  ))
                    image:setAnchorPoint( v:getAnchorPoint() )
                    
                    --删除
                    v:removeFromParent()
                    
                    --添加
                    image:setName( v:getName() )
                    node:addChild(image , zorder_start )
                    image:setLocalZOrder( zorder_start )
    
                    image:setVisible( v:isVisible() )
    
                     
                    print( "新加widget:" , image:getPositionX() , image:getPositionY() , image:getContentSize().width, image:getContentSize().height   )
                end
                
                v:setLocalZOrder( zorder_start )
                
                
                
                zorder_start = check9ScaleImage(  v , zorder_start+1   )
            end -- end for
            
            node:sortAllChildren()
            
            return zorder_start
            
        end --end func
        check9ScaleImage(  node_widget_PlayerCenter_  )
    end
    
    return node_widget_PlayerCenter_
end



--[[
size:控件大小
pos:控件位置
fontsize：内容文字的大小
fontcolor：文字的颜色
holdstr：hold文字的内容
flag：文本内容显示格式 比如 显示为密码
mode：文本内容输入格式 比如 邮件 

]]
function createEditBox( size,pos,fontsize,fontcolor,holdstr,flag,mode,returntype)
    
    --print ( "holdstr:"  ,  holdstr )
 
    local edit
    local fontname = "FZCuYuan.TTF"
    --static TextField *    create (const std::string &placeholder, const std::string &fontName, int fontSize)
    if game_config.IS_CHANGE_EDIT then
        edit = ccui.TextField:create( holdstr,fontname,fontsize )
        edit:setAnchorPoint(cc.p(0,0.5))
        edit:setPosition(pos)
        edit:setSize( size )
        edit:setTouchAreaEnabled(true)
        edit:setTouchSize(size)

        if flag == cc.EDITBOX_INPUT_FLAG_PASSWORD then
            edit:setPasswordEnabled(true)
        end

        edit.getText = function ( self  )
            return edit.getStringValue( self )
        end

        edit.setPlaceholderFontColor = function ( self,color )
            
        end

        edit.setFontColor = function ( self,color )
            print("this is setFontColor")
            --edit.setTextColor(self,color)
        end
        edit.setReturnType = function ( self, return_type ) -- setFontColor = function ( self,color )

        end

        edit.registerScriptEditBoxHandler  = function ( self, callBack )
            local userKeyStatus = false
            local textField = self
            --文本输入
            local function textFieldEvent(sender, eventType)
                print ( "eventType" , eventType  )
                
                if eventType == ccui.TextFiledEventType.attach_with_ime then
                    --[[\
                    if userKeyStatus then
                        textField:setAttachWithIME(false)
                    else
                        textField:setAttachWithIME(true)
                    end
                    --]]
                    callBack( "began" , sender  )
                elseif eventType == ccui.TextFiledEventType.detach_with_ime then

                    userKeyStatus = false
                    callBack( "ended" , sender  )

                elseif eventType == ccui.TextFiledEventType.insert_text then
                    callBack( "changed" , sender  )
                elseif eventType == ccui.TextFiledEventType.delete_backward then
                    callBack( "changed" , sender  )
                end
            end

            textField:addEventListenerTextField(textFieldEvent)

        end

    else

        edit = cc.EditBox:create(size ,cc.Scale9Sprite:create())
        edit:setAnchorPoint(cc.p(0,0.5))
        edit:setPosition(pos)
        edit:setFont(fontname,fontsize)
        edit:setPlaceholderFont(fontname,fontsize)
        edit:setFontColor(fontcolor)
        edit:setPlaceHolder(holdstr)
        
        if flag then
            edit:setInputFlag(flag)
        end

        edit:setInputMode(cc.EDITBOX_INPUT_MODE_EMAILADDR)

        if mode then
            edit:setInputMode(mode)
        end

        edit:setReturnType(cc.KEYBOARD_RETURNTYPE_DONE)

        --[[local function editBoxTextEventHandle(strEventName,pSender)

            tips_layer.createFadeTips(require("gameText").getGameText("ID_TEXT_MYLIB_003"),strEventName)

            if strEventName == "return" then
                require("tips_layer")
                tips_layer.createFadeTips(require("gameText").getGameText("ID_TEXT_MYLIB_003"))
            end
        end


        edit:registerScriptEditBoxHandler(editBoxTextEventHandle)]]
    end

    return edit
end

function runScaleAction( w )
    --w
    local acArray = {}

    w:setScale(0)
    table.insert( acArray,cc.ScaleTo:create(0.08,1.1) )
    table.insert( acArray,cc.ScaleTo:create(0.15,0.9) )
    table.insert( acArray,cc.ScaleTo:create(0.15,1) )
    w:runAction(cc.Sequence:create(acArray))

end

function runScaleFade( w ,fun)
        
    local fade_1 =  cc.CallFunc:create( function ( )
        w:removeFromParent()
        if fun then
            fun()
        end
    end )

    local fade =  cc.Sequence:create(cc.ScaleTo:create(0.15,0.45) , fade_1 )
    
    w:runAction( fade )

    --[[FadeOut,
    ScaleTo
    Spawn]]

end


--用法 mylib.showInt64( id64 )
function showInt64( id64 )
    
    result = ""
    for i=1, string.len(id64) do
        result =string.format( "%02x" , string.byte( id64, i  ) ) ..  result
    end
    return result
end


--下标 + hash 总元素个数
function tableTotalSize(tab)
	local ret = 0
	if(tab~=nil and type(tab)=="table")then
		for k,v in pairs(tab) do
			ret = ret + 1
		end
	end
	return ret
end

function int2AbbreviateString(interger, isLower)
    if math.abs(interger) < 10e3 then
        return tostring(interger)
    elseif math.abs(interger) <= 10e6 then
        return tostring(math.floor(interger / 10e3)) .. (isLower and 'k' or 'K')
    elseif math.abs(interger) <= 10e9 then
        return tostring(math.floor(interger / 10e6)) .. (isLower and 'm' or 'M')
    elseif math.abs(interger) <= 10e12 then
        return tostring(math.floor(interger / 10e9)) .. (isLower and 'b' or 'B')
    else
        return tostring(math.floor(interger / 10e12)) .. (isLower and 't' or 'T')
    end
end

function send_request(proto_name, params)
    local pb_data = require("protobuf").encode(proto_name , params or {})
    return require("cNetwork").send_request(proto_name,pb_data)
end

--敏感词过滤
--每检查到敏感词将会触发一次回调
--函数将返回过滤后的text
--不采用全部检查完再回调的原因是为了让ababa的字段检查aba的敏感词时只产生一次回调而非两次
--所以在对长字符串处理时有可能会有性能问题（每次都重新生成了一个新字符串）
----------------callback的格式-------------------
--function callback(text, start_index, end_index)
--    processing
--    return processed_text, new_start_searching_index
--end
--参数：需要处理的字符串，敏感词字段的开头，敏感词字段的结尾
--返回：处理过后的字符串，处理后需要继续查找的开头位置
--------------callback格式end---------------------
function sensetiveWordsCheck(text, callback)
    if text == nil and string.len(text) == 0 then
        return ""
    end

    local forbidden_text = global_data.censor["FORBIDDEN"]["TEXT"]
    local lower = string.lower(text)

    for _, each_text in ipairs(forbidden_text) do
        if each_text ~= "" then
            local each_lower = string.lower(each_text)
            local search_start = 1
            repeat
                local index_start, index_end = string.find(lower, each_lower, search_start)
                if index_start then
                    lower, search_start = callback(text, index_start, index_end)
                    text = lower
                    lower = string.lower(lower)
                else
                    break
                end
            until search_start == string.len(lower) + 1
        end
    end

    return text
end

-- 敏感词过滤回调的通用方法，传入想要替换敏感词的字符，返回供sensetiveWordCheck使用的callback
-- 第一个参数为需要的字符，第二个参数为是否重复，比如abc替换为***时传入("*", true)
-- 使用方式示例：
-- sensetiveWordsCheck(str, getSensetiveWordReplaceCallback("*", true))
function getSensetiveWordReplaceCallback(word, isRepeat)
    local len = string.len(word)
    local replace = word
    -- 一次性过滤所有的敏感词，但不检查大小写，进入下一轮检查
    return function (text, start_index, end_index)
        if isRepeat then
            local unicode_len = getUnicodeStringLen(text, start_index, end_index)
            replace = string.rep(word, unicode_len)
            len = unicode_len * len
        end

        text = string.gsub(text, string.sub(text, start_index, end_index), replace)
        return text, start_index + len
    end
end


-- 获得unicode的单字符所占长度
function getUnicodeWordLen(curByte)
    local arr = {0xc0, 0xe0, 0xf0, 0xf8}
    for i = 1, #arr do
        if curByte < arr[i] then
            return i
        end
    end

    print("getUnicodeWordLen：错误字符")
    return 1 --出现了错误字符
end

-- 遍历方法，逐个遍历找到的字符
-- 回调方法使用同sensetiveWordsCheck的回调
-- 注意！！使用end_index最好不要在callback改变字符串，否则将导致未知行为！
function walkUnicodeString(str, callback, start_index, end_index)
    start_index = start_index or 1
    local strlen = string.len(str)
    local end_index_tmp = end_index or strlen

    i = start_index
    while i <= end_index_tmp do
        local char_len = getUnicodeWordLen(string.byte(str, i))
        str, i = callback(str, i, i + char_len - 1)
        end_index_tmp = end_index and end_index or strlen
    end
end

-- 获取字符串的unicode长度
function getUnicodeStringLen(str, start_index, end_index)
    start_index = start_index or 1
    end_index = end_index or string.len(str)

    local len = 0
    local function walk(walk_str, start_index, end_index)
        len = len + 1
        return walk_str, end_index + 1
    end
    walkUnicodeString(str, walk, start_index, end_index)

    return len
end

-- 字符串最大长度限制
-- 返回两个值，第一个为处理后的字符串，第二个为特征码，0为未超出长度限制，1为刚好达到长度限制，2为超出长度限制
function limitWordsCheck(str, limit)
    local len = string.len(str)
    if len < limit then
        return str, 0
    elseif len == limit then
        return str, 1
    end
    
    -- 找出最后超出长度的字符index
    local index = 0
    local function walk(walk_str, start_index, end_index)
        if end_index <= limit then
            index = end_index
            return walk_str, end_index + 1
        else
            return walk_str, len + 1
        end
    end

    walkUnicodeString(str, walk)
    return string.sub(str, 1, index), 2
end


-- 获取总秒数
function getSeconds(day, hour, min, sec)
    day = day or 0
    hour = hour or 0
    min = min or 0
    sec = sec or 0
    return day * 24 * 60 * 60 + hour * 60 * 60 + min * 60 + sec
end


function tryConvert2Tradition( text )
    --[[
    local tab = {}
    --字体中有的字符
    local t_available = {}
    for uchar in string.gfind(text, "[%z\1-\127\194-\244][\128-\191]*") do
        tab[#tab+1] = uchar
    end
    
    for i , char in ipairs(tab) do
        print ( i, char  )
        if global_data.ttfSimplifiedMap[char] then
            text = string.gsub( text , char , global_data.ttfSimplifiedMap[char]  )
            print ( "\t\t" , global_data.ttfSimplifiedMap[char]  )
        end
    end
    --]]
    --[[
    if game_config.bIS_TRADITIONAL_VERSION then
        for k, v in pairs( global_data.ttfSimplifiedMap ) do
     
        end
    end
    --]]
    return text
end


--UI system ========================================================================================
require( "KEYS_FOR_UISTATUS" )
-- remove expired ui status , often caused by userdata has been released
local function checkInvalidUIStatus()
    local cnt = 0
    for key ,v  in pairs ( _G.__UIStatus__ ) do
        local events = v 
        for idx , event in pairs(events) do
            cnt = cnt + 1
        end
    end

    print ( "UI event b4 check:" , cnt  )

    for key ,v  in pairs ( _G.__UIStatus__ ) do
        local events = v 
 
        local i = 1 
        while i<= #events do
            local event = events[i]

            local func = event.func
            local params = event.params
            local ui_obj = params[1]

            if not (func and params and  ui_obj and (not tolua.isnull(ui_obj) ) ) then
               table.remove( events , i )
               print( "删除:" , key , unpack(params) )
            else
               i = i+1
            end
            
        end --end while
    end

    local cnt = 0
    for key ,v  in pairs ( _G.__UIStatus__ ) do
        local events = v 
        for idx , event in pairs(events) do
            cnt = cnt + 1
        end
    end

    print ( "UI event after check:" , cnt  )
end


--t_params : { value, other params }
function registerUIStatusEvent( key , ui_obj , t_params )
--[ [
    if not key then return end
    if not ui_obj then return end
    if ui_obj and tolua.isnull(ui_obj) then return end

    --调用参数
    t_params = t_params or {}
    
    --初始化 status table, if not exists
    if not _G.__UIStatus__ then
        _G.__UIStatus__ = {}
    end
    
    checkInvalidUIStatus()

    print ( tolua.type( ui_obj ) ,  t_params[1] and type(t_params[1])  ) 
    --确定 注册函数
    local func = nil 
    --Label
    if tolua.type( ui_obj ) == 'ccui.Text' or  tolua.type( ui_obj ) == 'ccui.TextAtlas' then
        --print ( "as function setString" )
        func = ui_obj.setString
    end
    --Image
    if tolua.type( ui_obj ) == 'ccui.ImageView'  and t_params[1] and type(t_params[1]) == "string"  then
        --print ( "as function setString" )
        func = ui_obj.loadTexture 
    end
    
    --[[
    --Button
    if tolua.type( ui_obj ) == 'ccui.Button'  and t_params[1] and type(t_params[1]) == "string"  then
        --print ( "as function setString" )
        func = ui_obj.loadTextureNormal
    end
    --]]

    if not func then return end

    print( 'to register UIStatus:' , key  )
    
    --添加入口
    if not _G.__UIStatus__[key] then
        _G.__UIStatus__[key] = {}
    end
    
    table.insert( t_params , 1 , ui_obj )
    local t_event = { ["func"] = func , ["params"] =  t_params }
    
    table.insert( _G.__UIStatus__[key] , t_event )
    
    

--]]  
end


function setUIStatus( t )
    --初始化 status table, if not exists
    if not _G.__UIStatus__ then
        _G.__UIStatus__ = {}
    end
    
    checkInvalidUIStatus()

    for k,v  in pairs ( t ) do
        local events = _G.__UIStatus__[k] or {}

        print ( k, "nEvents:" , #events, events[1] )
        
        --event key 下面的所有事件
        for _ , event in ipairs(events) do
            local func = event.func
            local params = event.params
            local ui_obj = params[1]
            
            --debug
            if  not func then print('func released') end
            if  not ui_obj then print('ui_obj not exist') end
            if ui_obj and tolua.isnull(ui_obj) then print('ui_obj released') end
            
            if func and params and  ui_obj and (not tolua.isnull(ui_obj) ) then
                --调用参数中,加入新值
                params[2] = v 
                func( unpack( params ) )
            end
        end
    end
end

function setButtonEnable(btn, t)
    btn:setTouchEnabled(t)
    btn:getVirtualRenderer():setGLProgramState( t and cc.GLProgramState:getOrCreateWithGLProgramName( "ShaderPositionTextureColor_noMVP" ) or cc.GLProgramState:getOrCreateWithGLProgramName( "shader_gray" ) )
end


--[[
1. return the bundle-version of app ， eg. 1.4.2
2. the return value is a string value
3. in platform except iOS and android, it will return "unknown"
--]]
function getBundleVersion()
    local bundleVersion
    local targetPlatform = cc.Application:getInstance():getTargetPlatform()
    if (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform)  then

        local ok, ret =  LuaObjcBridge.callStaticMethod("AppController", "getBundleVersion" ,  { } )
        if ok then
            bundleVersion =   ret
        end

    elseif cc.PLATFORM_OS_ANDROID == targetPlatform then

        local luaj = require("luaj")
        -- . 要换成 /
        local className="com/dst/nbahero/NBAHeroMain"
        local params={ }
        local desc="()Ljava/lang/String;"
        
        local ok, ret =luaj.callStaticMethod(className,"getBundleVersion",params , desc )
        
        if ok then
            bundleVersion =  ret
        end

    end

    bundleVersion = bundleVersion or "unknown"

    return tostring(bundleVersion)
end

-- end UI System ===================================================================================================

return mylib


