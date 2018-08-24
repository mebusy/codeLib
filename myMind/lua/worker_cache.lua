
local P = {}
worker_cache  = P

setmetatable(P, {__index = _G})
setfenv(1, P)


local function get_from_cache(_cache, key)
    local value =  _cache:get( key )
    -- print( "get from cache : " , key, ' ' ,value  )
    return value 
end

local function set_to_cache(_cache, key, value, exptime)
    if not exptime then
        exptime = 0
    end
    local succ, err, forcible = _cache:set( key, value , exptime  )
    return succ, err 
end


function delete_cache( _cache,  key )
    _cache:delete( key )
end


function fetch( _cache , key, query,  exptime ) 

    local query_content = get_from_cache( _cache , key  )

    if query_content == nil then
        local db_op = require( "db_op" )
        local res ,err = db_op.db_query( query )
        if not res then
            print( "query from db failed :" , err  )
            return 
        end
        print( "query from db:",  res  )

        query_content = res 
        
        -- update the shm cache with the newly fetched value
        local succ, err = set_to_cache( _cache,  key, query_content , exptime )
        if not succ then
            ngx.log( ngx.ERR , "set data to  cache error: " , err  ) 
        end
    end

    return query_content 

end 

return worker_cache
