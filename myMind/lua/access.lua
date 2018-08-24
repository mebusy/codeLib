-- ngx.exit in header_filter not work 
local m = ngx.req.get_method()

if m ~= "POST" and ngx.var.uri ~= "/nginx_status" then
    return ngx.exit( ngx.HTTP_METHOD_NOT_IMPLEMENTED )
end


-- editor 
local editorAPI = require( "editorAPI" )
if editorAPI.isEditorAPI( ngx.var.uri ) then 
    print ( "editor API, no limit req and Authorization" )
    return 
end

-- limit req
-- local limit_req = require( "nginx.limit_req" )
-- limit_req.income()


-- Authorization 

-- auth
local req_headers = ngx.req.get_headers()
local userID = req_headers["userID"] 
local Authorization = req_headers["Authorization"] 
-- print( "userID:" , userID )
-- print( "Authorization:" , Authorization )


local needAuth = false -- true

-- for develop server 
-- print( ngx.var.http_referer  )
-- if not _G.PROD  and (userID or "")== ""  and (Authorization or "") == "" then 
--     print ( "develop server, may skip Authorization " )
--     needAuth = false 
-- end


if needAuth then
    local API_KEY = "UMC_HDA_OHIAOSJDAS"
    if userID == nil or Authorization == nil then
        ngx.log( ngx.ERR , " Authorization info not provided !!! " ) 
        return ngx.exit( ngx.HTTP_UNAUTHORIZED )
    end

    local encrypt = require( "nginx.encrypt" )
    local md5_hex = encrypt.md5( string.format( "%s:%s" , userID , API_KEY  ) )
    if md5_hex == Authorization then
        ngx.ctx.authorized_header_userid = userID 
        print ( "Authorization successfully !!" )
    else
        ngx.log( ngx.ERR , " Authorization failed !!! " , md5_hex, " " , Authorization  )
        return ngx.exit( ngx.HTTP_UNAUTHORIZED )
    end
end


