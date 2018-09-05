
local db_op = require( "db_op" )
local json = require('cjson')

local tbl_name = "tbl_keynote"

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

local keys = { "key","depth" }
local query = ""
for _ , key in ipairs(keys) do
    if t[key] == nil then
        return ngx.exit(ngx.HTTP_BAD_REQUEST)
    end
end


local http = require "resty.http"
local httpc = http.new()
local res, err = httpc:request_uri(
    string.format(  "http://10.192.81.82:3031/searchentry?%s" ,  ngx.encode_args(t)  ) , 
    {
        method = "GET",
    }
)

if 200 ~= res.status then
    ngx.exit(res.status)
end

-- print(res.body)

ngx.say( json.encode( { data = "success" , path  = res.body  } ) )


