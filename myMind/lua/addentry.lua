
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
local query = string.format( [[SELECT * FROM %s WHERE ( %s = %s AND  %s = %s ) OR  ( %s = %s AND  %s = %s ); ]] , 
                            tbl_name , 
                            keys[1],sql_str(t[keys[1]]), keys[2],sql_str(t[keys[2]]),
                            keys[1],sql_str(t[keys[2]]), keys[2],sql_str(t[keys[1]]) 
                        )
print(query)

local res ,err = db_op.db_query( query )
if not res then
    return ngx.say( json.encode( { err= "编辑失败!!"} ) )
end


ngx.say( json.encode( { data = "success" } ) )
