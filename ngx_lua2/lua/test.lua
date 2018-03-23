local body = string.rep ("call lua file." , 1024*1024)
--ngx.header["Content-Length"] = #body
ngx.log( ngx.ERR, ngx.req.raw_header());
ngx.say( body ) 

