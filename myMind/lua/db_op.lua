
local P = {}
db_op = P

setmetatable(P, {__index = _G})
setfenv(1, P)

local _init = require( "_init" )

function db_query( query ) 

    local mysql = require "resty.mysql"
    local db, err = mysql:new()
    if not db then
        ngx.log( ngx.ERR ,"failed to instantiate mysql: ", err)
        return false , err
    end

    db:set_timeout(1000) -- 1 sec

    local ok, err, errcode, sqlstate = db:connect{
        host = _init.mysql_host ,
        port = 3306,
        database = _init.mysql_dbname  ,
        user = _init.mysql_user ,
        password = _init.mysql_pwd , 
        charset = "utf8",
        max_packet_size = 1024 * 1024,
    }

    if not ok then
        ngx.log( ngx.ERR ,"failed to connect: ", err, ": ", errcode, " ", sqlstate)
        return false , err
    end

    print( "connected to mysql" )    


    local res, err, errcode, sqlstate = db:query( query )
    if not res then
        ngx.log( ngx.ERR ,"bad result: ", err, ": ", errcode, ": ", sqlstate, ".")
        return false , err
    end

    local json = require( "cjson" )
    local resJson = json.encode( res )

    -- put it into the connection pool of size 100,
    -- with 10 seconds max idle timeout
    local ok, err = db:set_keepalive(10000, 100)
    if not ok then
        ngx.log( ngx.ERR ,"failed to set keepalive: ", err)
    end

    -- or just close the connection right away:
    -- local ok, err = db:close()
    -- if not ok then
    --     ngx.say("failed to close: ", err)
    -- end

    return resJson
end



return db_op 
