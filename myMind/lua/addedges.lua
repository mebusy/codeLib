
local P = {}
addedges  = P

setmetatable(P, {__index = _G})
setfenv(1, P)

local db_op = require( "db_op" )
local json = require('cjson')
local _init = require( "_init" )


local tbl_name = "tbl_keynote"
local sql_str = ndk.set_var.set_quote_sql_str

local cache_ngx = ngx.shared.global_shared_dict

local KEY_OFFSET = "key_graph_edge_offset"
local STEP = 500 
local key = KEY_OFFSET

function newOffset( offset ) 
    local succ, err, forcible = cache_ngx:set(key, offset , 0 )
    if not succ then
        ngx.log( ngx.ERR, "save graph offset to cache failed " )
        return 
    end
end

function func()
    -- print(  'lua addedges')

    local offset = cache_ngx:get( key ) or 0

    -------------------------
    
    local query = string.format( [[SELECT  * from %s LIMIT %d OFFSET %d ]] , 
                    tbl_name, STEP , offset  )
    local res ,err = db_op.db_query( query )
    if not res then
        ngx.log( ngx.ERR , " db error when try addedges " )
        return 
    end

    local t_res = json.decode( res ) 
    local nEntry = #t_res 

    -- print ( nEntry ,  res  )

    if nEntry == 0 then
        newOffset( 0 )
        return 
    else
        newOffset( offset+STEP)
    end

    local t = {}
    for _ , entry in ipairs( t_res ) do
        t[ #t+1 ] = { entry.key1 , entry.key2, {  relation = entry.relation }  }
    end

    local body = json.encode( t )
    -- print(body)

    --[ [
    local HOST_IP = _init.uwsgi_host

    local UWSGI = string.format( "%s:3031", HOST_IP  )

    local http = require "resty.http"
    local httpc = http.new()
    local res, err = httpc:request_uri(
        string.format(  "http://%s/addedges" , UWSGI ) , 
        {
            method = "POST",
            body = body 
        }
    )

    if res == nil or 200 ~= res.status or res.body ~= "success" then
        -- ngx.exit(res.status)
        ngx.log( ngx.ERR, "query to uwsgi to add edges failed " )
        return
    end
    --]]
    ------------------------
    -- print ( "lua, add edges succussfully: " , body )
     
end

return addedges

