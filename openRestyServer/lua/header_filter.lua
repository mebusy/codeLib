
-- following code is to solve Swagger Editos issue
local m = ngx.req.get_method()
if m == "GET" or m == "POST" then
    ngx.header["Access-Control-Allow-Origin"] = ngx.var.http_origin
end


-- following code is to allow only POST method
if m~= "POST" then
    return ngx.exit(ngx.HTTP_METHOD_NOT_IMPLEMENTED )
end


