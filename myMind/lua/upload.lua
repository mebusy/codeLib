

local upload = require "resty.upload"
local json = require "cjson"
local uuid = require 'resty.jit-uuid'


local chunk_size = 4096 -- should be set to 4096 or 8192
                     -- for real-world settings
local realFileName = nil 
local cacheFolder2ndLvlPath = "ads/"
local cacheFolder = '/usr/local/openresty/nginx/staticRes/' .. cacheFolder2ndLvlPath 

local form, err = upload:new(chunk_size)
if not form then
    ngx.log( ngx.ERR ,"failed to new upload: ", err)
    return ngx.exit(500)
end

form:set_timeout(1000) -- 1 sec

local file

while true do
    local typ, res, err = form:read()
    if not typ then
        ngx.log( ngx.ERR , json.encode( { err= err } )  )
        return ngx.exit(500)
    end

    
    if typ == "header" then
        if res[1]  == "Content-Disposition" then
            -- 解析上传的文件名
            -- form-data; name="testFileName"; filename="testfile.txt"
            local regex = [[filename\s*=\s*\"([^"]+?)\.(\w+)\"]]
            local m = ngx.re.match( res[2] , regex, "jo")

            if m and m[2] then 
                -- print( "file ext:" , m[2] )
                realFileName = uuid:generate_v4() .. '.'  .. m[2] 
                local path = cacheFolder .. realFileName
                -- print ( 'path:' , path  )

                file , file_err  = io.open( path, "wb+") 
                if file_err then
                    ngx.log( ngx.ERR, file_err  )
                end 

                if not file then 
                    ngx.log( ngx.ERR , json.encode( { err= "failed to open file " .. path } )  )   
                    return ngx.exit(500)
                end

            else
                 ngx.log( ngx.ERR , json.encode( { err= "can not get uploaded filename" } )  )   
                 return ngx.exit(500)
            end
            
            
        end

        -- local file_name = my_get_file_name(res)
        -- if file_name then
        --     file = io.open(file_name, "w+")
        --     if not file then
        --         ngx.log( ngx.ERR , json.encode( { err= "failed to open file " .. file_nam } )  )
        --         return ngx.exit(500)
        --     end
        -- end

     elseif typ == "body" then
        if file then
            file:write(res)
        end

    elseif typ == "part_end" then
        file:close()
        file = nil

    elseif typ == "eof" then
        break

    else
        -- do nothing
    end


end

local typ, res, err = form:read()
ngx.say( json.encode( { file = cacheFolder2ndLvlPath .. realFileName } ) )
