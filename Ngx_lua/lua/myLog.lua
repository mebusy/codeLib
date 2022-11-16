
local _raw_ngx_log = ngx.log 
ngx.log = function ( level , ... )
    local t = { ... }

    for k,v in pairs(t) do
        local tp = type( v )
        if v==nil then
          t[k] = "nil"
        elseif tp == "number" or tp == "string" then
  
        elseif tp == "boolean" then
          t[k] = v and "true" or "false"
        else
          t[k] = tp
        end  
    end

    pcall( function()  _raw_ngx_log( level , table.concat( t, " " )  )  end  )
end

print = function ( ... )
    ngx.log( ngx.NOTICE, ... )
end
