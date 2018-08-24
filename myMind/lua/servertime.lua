

-- ngx.header.content_type = 'application/json'
local json = require( "cjson" )
ngx.say( json.encode( { utc=ngx.utctime(), time = ngx.time() } ) )





