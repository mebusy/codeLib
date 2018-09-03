
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

local keys = { "key1", "key2" , "relation" }
for _ , key in ipairs(keys) do
    if t[key] == nil then
        return ngx.exit(ngx.HTTP_BAD_REQUEST)
    end
end

local sql_str = ndk.set_var.set_quote_sql_str

local query = string.format( [[UPDATE `%s` SET relation = %s WHERE key1 = %s AND key2 = %s ; ]] , 
                    tbl_name , 
                     sql_str(t["relation"]),sql_str(t["key1"]), sql_str(t["key2"])   
                )
local res ,err = db_op.db_query( query )
if not res then
    ngx.log( ngx.ERR , err  )
    return ngx.say( json.encode( { err = err } ) )
end

ngx.say( json.encode( { data = "success" } ) )
