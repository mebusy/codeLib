
local P = {}
game_cache  = P

setmetatable(P, {__index = _G})
setfenv(1, P)

-- global_shared_dict

local function get_from_global_cache(key)
    local cache_ngx = ngx.shared.global_shared_dict
    local value = cache_ngx:get(key)
    return value
end

local function set_to_global_cache(key, value, exptime)
    if not exptime then
        exptime = 0
    end

    -- print( "set_to_global_cache , exptime: " ,  exptime  )
    local cache_ngx = ngx.shared.global_shared_dict
    local succ, err, forcible = cache_ngx:set(key, value, exptime)
    return succ, err
end


function fetch( key, query , exptime ) 

    local query_content =  get_from_global_cache( key  )

    if query_content == nil then
        local resty_lock = require "resty.lock"
        local db_op = require( "db_op" )

        -- cache miss!
        -- step 2: 
        local lock, err = resty_lock:new("my_locks")
        if not lock then
            ngx.log( ngx.ERR , "failed to lock : " , err )
            return 
        end

        local elapsed, err = lock:lock(key)
        if not elapsed then
            ngx.log( ngx.ERR , "failed to acquire the lock:"  , err )
            return 
        end
        
        -- lock successfully acquired!
        
        -- step 3:
        -- someone might have already put the value into the cache
        -- so we check it here again:
        local val, err = get_from_global_cache(key)
        if val then
            local ok, err = lock:unlock()
            if not ok then
                ngx.log( ngx.ERR , "failed to unlock 1 : " , err )
            end

            return val 
        end

        --- step 4:
        --Query the backend (the data source) for the value, put the result into the cache, 
        --and then release the lock currently held by calling unlock.
        --

        local res ,err = db_op.db_query( query )
        if not res then
            print( "query from db failed :" , err  )

            local ok, err = lock:unlock()
            if not ok then
                ngx.log( ngx.ERR , "failed to unlock 2 : " , err )
            end

            return 
        end
        print( "query from db:" , res  )

        query_content = res 
        
        -- update the shm cache with the newly fetched value
        local succ, err = set_to_global_cache( key, query_content , exptime  )
        if not succ then
            ngx.log( ngx.ERR , "set data to global cache error: " , err  ) 
        end

        local ok, err = lock:unlock()
        if not ok then
            ngx.log( ngx.ERR , "failed to unlock 3: " , err )
        end
    end

    return query_content 

end 

return game_cache
