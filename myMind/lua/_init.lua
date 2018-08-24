local P = {}
_init = P

setmetatable(P, {__index = _G})
setfenv(1, P)

_G.PROD = true

-- 获取 nginx root 目录 --------------------------
_G.NGX_ROOT = "/usr/local/openresty/nginx"


-- lua search path
-- print( package.path )
package.path = string.format("%s/?.lua;%s", "resty"  , package.path)
-- print( package.path )

-- load mysql config -----------------------------
local path = NGX_ROOT .. "/lua/_db.config"
for line in io.lines(path) do 
    local cmd = string.format( [[_init.%s]] , line )  
    pcall( function()  loadstring( cmd )() end )
end

local uuid = require 'resty.jit-uuid'
uuid.seed()

require( "nginx/getReqBody" )



return _init 


