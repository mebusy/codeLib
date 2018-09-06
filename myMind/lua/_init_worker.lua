local delay = 5  -- in seconds
local new_timer = ngx.timer.at
local log = ngx.log
local ERR = ngx.ERR
local check

local addedges = require("addedges") 

check = function(premature)
    if not premature then
        -- do the health check or other routine work
        local ok, err = new_timer(delay, check)
        if not ok then
            log(ERR, "failed to create timer: ", err)
            return
        else
            -- print ( "timer" )
            addedges.func()  
        end
    end
end

if 0 == ngx.worker.id() then
    local ok, err = new_timer(delay, check)
    if not ok then
        log(ERR, "failed to create timer: ", err)
        return
    end
end


