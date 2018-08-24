
local P = {}
encrypt = P

setmetatable(P, {__index = _G})
setfenv(1, P)

function md5( str ) 
    local resty_md5 = require "resty.md5"
    local md5 = resty_md5:new()
    if not md5 then
        ngx.log( ngx.ERR , "failed to create md5 object")
        return ngx.exit( ngx.HTTP_INTERNAL_SERVER_ERROR )
    end

    local ok = md5:update( str )
    if not ok then
        ngx.log( ngx.ERR , "failed to add data")
        return ngx.exit( ngx.HTTP_INTERNAL_SERVER_ERROR )
    end

    local digest = md5:final()

    local resty_str = require "resty.string"
    return resty_str.to_hex(digest)  
end



return encrypt
