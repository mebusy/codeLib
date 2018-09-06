
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
-- print(query)

local res ,err = db_op.db_query( query )
if not res then
    return ngx.say( json.encode( { err = err } ) )
else
    local t_res = json.decode( res ) 
    if t_res == nil then
        return ngx.say( json.encode( { err = "json decode error" } ) ) 
    end
    if #t_res > 1 then 
        return ngx.say( json.encode( { err = "dup keys combination! please check it!" } ) ) 
    end
    if #t_res == 1 then 
        return ngx.say( json.encode( { err = string.format("entry already exist", t_res[1][keys[3]]  ) , action = "forceupdate", info=  t_res[1] } ) ) 
    end
end

local query = string.format( [[INSERT INTO `%s` ( %s,%s,%s ) VALUES ( %s,%s,%s ); ]] , 
                    tbl_name , keys[1],keys[2],keys[3],  
                     sql_str(t[keys[1]]),sql_str(t[keys[2]]), sql_str(t[keys[3]])   
                )
local res ,err = db_op.db_query( query )
if not res then
    ngx.log( ngx.ERR , err  )
    return ngx.say( json.encode( { err = err } ) )
end

ngx.say( json.encode( { data = "success" } ) )
ngx.eof()

-------------------------------------

local _init = require( "_init" )
local HOST_IP = _init.uwsgi_host

local UWSGI = string.format( "%s:3031", HOST_IP  )

local http = require "resty.http"
local httpc = http.new()

local body = { { t[keys[1]] , t[keys[2]] ,  {  relation = t[keys[3]] }  }  }
local res, err = httpc:request_uri(
    string.format(  "http://%s/addedges" , UWSGI ) , 
    {
        method = "POST",
        body = json.encode( body ) 
    }
)

if res == nil or 200 ~= res.status or res.body ~= "success" then
    -- ngx.exit(res.status)
    ngx.log( ngx.ERR, "query to uwsgi to add ENTRY failed " )
    return
end

