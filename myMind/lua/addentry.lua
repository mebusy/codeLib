
local db_op = require( "db_op" )
local json = require('cjson')

local tbl_name = "tbl_announcement"

-- get request body
local data = getReqBody()
if not data then
    return ngx.exit(ngx.HTTP_BAD_REQUEST)
end
-- print( data )

-- decode body data
local t = json.decode( data )
if not t then
    return ngx.exit(ngx.HTTP_BAD_REQUEST)
end


local sql_str = ndk.set_var.set_quote_sql_str


ngx.say( json.encode( { data = "success" } ) )
