
local luaj = {}

local callJavaStaticMethod = LuaJavaBridge.callStaticMethod

local function checkArguments(args, sig)
    if type(args) ~= "table" then args = {} end
    if sig then return args, sig end

    sig = {"("}
    for i, v in ipairs(args) do
        local t = type(v)
        if t == "number" then
            sig[#sig + 1] = "F"
        elseif t == "boolean" then
            sig[#sig + 1] = "Z"
        elseif t == "function" then
            sig[#sig + 1] = "I"
        else
            sig[#sig + 1] = "Ljava/lang/String;"
        end
    end
    sig[#sig + 1] = ")V"

    return args, table.concat(sig)
end

function luaj.callStaticMethod(className, methodName, args, sig)
    local args, sig = checkArguments(args, sig)
    --echoInfo("luaj.callStaticMethod(\"%s\",\n\t\"%s\",\n\targs,\n\t\"%s\"", className, methodName, sig)
    return callJavaStaticMethod(className, methodName, args, sig)
end

function luaj.registerLuaFunction( lua_func_name , lua_func ) 
    local className = "org/cocos2dx/lib/Cocos2dxLuaJavaBridge"
    local args = { lua_func_name, lua_func }
    local sigs = "(Ljava/lang/String;I)V"
    local ok = luaj.callStaticMethod(className,"registerLuaFunction",args,sigs)
    if not ok then
        print("============= register lua callback error")
    else
        print("------------- register lua callback success")
    end
    return ok 
end

return luaj
