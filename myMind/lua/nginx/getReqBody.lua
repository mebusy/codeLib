-- will required by _init

-- print ( "getReqBody required" )

function getReqBody() 

    -- ngx.req.get_body_data() 读请求体
    -- 如果请求体尚未被读取，请先调用 ngx.req.read_body 
    -- 如果请求体已经被存入临时文件，请使用 ngx.req.get_body_file 函数代替。

    local function getFile(file_name)
        local f = assert(io.open(file_name, 'r'))
        local string = f:read("*all")
        f:close()
        return string
    end

    ngx.req.read_body()
    local data = ngx.req.get_body_data()
    if nil == data then
        local file_name = ngx.req.get_body_file()
        -- ngx.say(">> temp file: ", file_name)
        if file_name then
            data = getFile(file_name)
        end
    end

    return data 
end
