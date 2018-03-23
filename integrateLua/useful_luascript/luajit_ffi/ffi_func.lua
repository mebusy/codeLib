--提交 新客户端前，暂时使用 luajit ffi 功能
--因为访问 系统剪切版，需要添加系统编码

local P = {}
ffi_func = P

setmetatable(P, {__index = _G})
setfenv(1, P)


local targetPlatform = cc.Application:getInstance():getTargetPlatform()

function setPasteboard( text )
    
    CCLOG (" ffi setPasteboard" )
    
    
    if (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform)  then
        local ffi = require'ffi'
        local objc = require'objc'
        print ("操作系统:" , ffi.os)
        
        objc.UIPasteboard:generalPasteboard():setString( text )
        
        
    elseif cc.PLATFORM_OS_ANDROID == targetPlatform then
    
        
    
    end
end


function getBundleVersion( )
    
    CCLOG ( "ffi getBundleVersion" )
    
    
    if (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform)  then
        local ffi = require'ffi'
        local objc = require'objc'
        
        
        local tp = type( objc.NSBundle:mainBundle().infoDictionary )
        if tp == 'function' then
            --local mylib =require("mylib")
            --mylib:callLater( function()  mylib:showAlert( tp )  end , 2 )
            
            return  objc.tolua( objc.NSBundle:mainBundle():infoDictionary():objectForKey( "CFBundleVersion" ))
        elseif  tp == 'cdata' then
        
            --local mylib =require("mylib")
            --mylib:callLater( function()  mylib:showAlert( tp )  end , 2 )
            
            return  objc.tolua( objc.NSBundle:mainBundle().infoDictionary  :objectForKey( "CFBundleVersion" ))
        end
        
    end
    
    return nil
end


function openAppStore( url )
   
   CCLOG ( "ffi openAppStore" )
   
   
   if (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform)  then
       local ffi = require'ffi'
       local objc = require'objc'
       
       objc.UIApplication:sharedApplication():openURL(  objc.NSURL:URLWithString(url) )
       
   end
end


function getSystemVersion()

    if (cc.PLATFORM_OS_IPHONE == targetPlatform) and jit then

        local ffi = require'ffi'
        local objc = require'objc'

        local t= objc.UIDevice:currentDevice()
        local tp = type(t )
        --print("tp :" , tp)
        if tp == 'function' then
            return  objc.tolua( objc.UIDevice:currentDevice():systemVersion() )
        elseif  tp == 'cdata' then
            return  objc.tolua( objc.UIDevice:currentDevice().systemVersion  )
        end

    end
    return nil
end

return ffi_func

