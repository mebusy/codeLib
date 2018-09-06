
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

-- TODO
local HOST_IP = "10.192.81.82"

local UWSGI = string.format( "%s:3031", HOST_IP  )

local http = require "resty.http"
local httpc = http.new()
local res, err = httpc:request_uri(
    string.format(  "http://%s/searchentry?%s" , UWSGI ,  ngx.encode_args(t)  ) , 
    {
        method = "GET",
    }
)

if res == nil or 200 ~= res.status then
    -- ngx.exit(res.status)
    return ngx.say( json.encode( { err = "uwsgi server down"  } ) )
end

local filename = res.body 
if filename ~= "" then
    filename = string.format( "http://%s:7011/%s" , HOST_IP , filename )
end

-- print(res.body)

ngx.say( json.encode( { data = "success" , path  = filename } ) )


