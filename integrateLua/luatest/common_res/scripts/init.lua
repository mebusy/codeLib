

-- for CCLuaEngine traceback
function __G__TRACKBACK__(msg)
    print("----------------------------------------")
    print("LUA ERROR: " .. tostring(msg) .. "\n")
    print(debug.traceback())
    print("----------------------------------------")
end


LUA_MODULE_CACHE=false


-- fix lua socket dispatch.lua bug
-- attempt to yield across C-call boundary 
local socket = require("socket")
local base = _G

if string.sub(base._VERSION, -3) == "5.1" then
  local function _protect(co, status, ...)
    if not status then
      local msg = ...
      if base.type(msg) == 'table' then
        return nil, msg[1]
      else
        base.error(msg, 0)
      end
    end
    if coroutine.status(co) == "suspended" then
      return _protect(co, coroutine.resume(co, coroutine.yield(...)))
    else
      return ...
    end
  end

  function socket.protect(f)
    return function(...)
      local co = coroutine.create(f)
      return _protect(co, coroutine.resume(co, ...))
    end
  end
end






-- xpcall(main, __G__TRACKBACK__)

print ('lua inited')

