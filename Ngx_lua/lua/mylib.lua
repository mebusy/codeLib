

module( "mylib" , package.seeall )




--连接到数据库
local function connect2DB( bMysql )

	--尝试注册 redis lua 脚本
	--只会注册一次
	redis_scripts.register()



	--不同数据库引擎
	local db_name = bMysql and game_config.TABLE_ALL_DB_NAMES[1] or game_config.TABLE_ALL_DB_NAMES[2] 
	local db_module = require( db_name )

	local db, err = db_module:new()
	if not db then
	    ngx.log( ngx.CRIT, string.format( "failed to instantiate %s: " , db_name  ), err)
	    return false
	end 

	db:set_timeout(1000) -- 1 sec

	--redis 没有 errno, sqlstate 返回值
	local ok, err, errno, sqlstate = bMysql 
		and db:connect {
		    host = db_config[db_name].host , 
		    port = db_config[db_name].port ,
		    database = db_config[db_name].database ,
		    user = db_config[db_name].user ,
		    password = db_config[db_name].password ,
		    max_packet_size = db_config[db_name].max_packet_size  }

	    or db:connect( db_config[db_name].host , db_config[db_name].port )

	print( "try connect to " , db_name )

	if not ok then
	    ngx.log( ngx.CRIT, " reason: " , err , ", errno: ", errno, ", state: ", sqlstate)
	    return false
	end

	return true , db
end

--立刻关闭链接
local function closeDB( db )
    -- ==or just close the connection right away:
    local ok, err = db:close()
    if not ok then
        ngx.log( ngx.ERR,  "failed to close: ", err)
    end
end

--关闭连接，并且 放入线程池
local function poolDB( db ) 
    -- put it into the connection pool of size 100,
    -- with 10 seconds max idle timeout
    local ok, err = db:set_keepalive(10000, 100)
    if not ok then
        ngx.log( ngx.ERR, "failed to set keepalive: ", err)
    end
end

function dbQuery( cmd , bMysql , ...  )
	--不同的数据库引擎
	local db_name = bMysql and game_config.TABLE_ALL_DB_NAMES[1]  or game_config.TABLE_ALL_DB_NAMES[2] 

    local ok, db     
    if ngx.ctx[ "db_opening_" .. db_name ] then
    	--print("存在打开的数据库连接")
    	ok, db = true , ngx.ctx[ "db_opening_" .. db_name ]
    else
    	--print("新建数据库连接")
    	ok, db = connect2DB( bMysql )
    	if ok and db then
    		--保存到全局变量
    		ngx.ctx[ "db_opening_" .. db_name ] = db
    	end
    end



    if ok then
    	--redis 没有 errno, sqlstate 返回值
    	if bMysql then
	    	local res, err, errno, sqlstate = db:query( cmd )
	        if not res then
	            --ngx.log( ngx.ERR , "bad result: ", err, ": ", errno, ": ", sqlstate, ".")
	            --如果出错，返回错误码
	            mylib.errorMsg( "dbQuery: " .. err )
	        end

	        --正确，返回
	        return res, sqlstate  
	    else	    	
	    	local t = {...}
	    	if cmd == "evalsha" then
	    		t[1] = redis_scripts[t[1]]
	    	end

    	    local ok, err = db[cmd]( db ,  unpack(t) )
            if not ok then
            	ngx.log( ngx.ERR ,cmd   )
                mylib.errorMsg( cmd .. ": " .. err )
            end

            --正确，返回
            return ok, err
	    end

    else
    	errorMsg ( msg_text.msgByID( "DB_CONNECT_ERR" ) )
    end
end

function logRedisLuaScript( ... )

	local key_script =  select(1 , ... )
	local script = redis_scripts.raw_scripts[ key_script ]
	local nKeys =  select(2 , ... )
	local nVals =  select('#' , ... ) -2 - nKeys

	for i=1,nKeys do
		local arg = select(2+i , ... )
		if type(arg) == 'string' then
			arg = '"' .. arg .. '"'
		end
		script = string.gsub( script , "KEYS%s*%[%s*" .. i .. "%s*%]" , tostring( arg )  )
	end
	for i=1,nVals do
		local arg = select(2+nKeys+i , ... )
		if type(arg) == 'string' then
			arg = '"' .. arg .. '"'
		end
		script = string.gsub( script , "ARGV%s*%[%s*" .. i .. "%s*%]" , tostring( arg )  )
	end
	print ( "调用脚本: \n " ..  script )

end



--返回错误信息，
--并立刻 终止 这次 lua 调用
function errorMsg ( msg , action ) 
	for _, db_name in ipairs ( game_config.TABLE_ALL_DB_NAMES ) do
		if ngx.ctx[ "db_opening_" .. db_name ] then
	   		--mylib.closeDB( ngx.ctx[ "db_opening_" .. db_name ] )
	   		poolDB( ngx.ctx[ "db_opening_" .. db_name ] ) 
	   	end
	end 

	local result = json.encode( { res = 1, msg = msg , act = action } )

	ngx.say(  result )
	ngx.log( ngx.ERR , result )

	ngx.exit( ngx.OK )
end


function okMsg( msg , action , t_data ) 
	for _, db_name in ipairs ( game_config.TABLE_ALL_DB_NAMES ) do
		--入 线程池
		if ngx.ctx[ "db_opening_" .. db_name ] then
	   		poolDB( ngx.ctx[ "db_opening_" .. db_name ] ) 
	   	end
	end 

	local t = { res = 0 , msg = msg , act = action  }
	if t_data then
		t.data = t_data 
	end
	local result = json.encode( t )

	ngx.say(  result )
	print( result )

	ngx.exit( ngx.OK )	
end

--获取 请求参数
--TODO 如果请求中有 pb 字段, 则 对应的数据 需要 protobuf decode
function getRequestUriArgs(  )
	-- body
	return ngx.req.get_uri_args()
end

--检查用户名是否合法
function checkUserAccNameValidity( user_acc , action  )
	--用户名合法性 , 字母 数字组合， 第一个必须是字母
	local i , j = string.find( user_acc , "^%a+%w*$" )
	if (not i) or string.len( user_acc ) > 16 or string.len( user_acc ) < 3 then
		mylib.errorMsg(  msg_text.msgByID(  "ILLEGAL_USER_NAME" ) , action  )
	end
end

--检查密码是否合法
function checkPasswordValidity( password , action  )
	--密码合法性 ,  字母 数字组合，  
	local i , j = string.find( password , "^%w+$" )
	if ( not i ) or string.len( password ) > 16 or string.len( password ) < 3 then
		mylib.errorMsg( msg_text.msgByID(  "ILLEGAL_PASSWORD" ) , action  )
	end
end

--生成 token
function genToken( user_id, time )
	local key = game_config.SERVER_PRIVATE_KEY
    local src = user_id .. time
    local digest = ngx.hmac_sha1(key, src)
    return ngx.md5( digest )
end

--生成加密秘密
function genCryptPassword( password )
	local key = game_config.SERVER_PASSWORD_KEY
    local digest = ngx.hmac_sha1(key, password)
    return ngx.md5( digest )
end


--保存到cookie
function save2cookie( t )
	--[[
	local t_cookie = {}
	local expires = ngx.cookie_time( ngx.time() + 1*60*60  )

	for k,v in pairs(t) do 
		table.insert( t_cookie ,  k .. "=" .. tostring( v ) .. ";" ..  "expires=" .. expires   )
	end
	--ngx.header["Set-Cookie"] =   { "token=" .. "aaaaaaa" ; "expires=" .. expires  };
	ngx.header["Set-Cookie"] = t_cookie
	--print( "cookie 2 save: " , string.join( t_cookie , ",") )
	--]]
end

--获取cookie 表
--[[
	--测试
	local t = mylib.getCookie()
	for k,v in pairs(t) do
		print ( "cookie: "   , k, " = " , v )
	end
--]]
function getCookie()
	local t = {}
	if ngx.var.http_cookie then
	    local s = ngx.var.http_cookie
	    for k, v in string.gmatch(s, "([%w_]+)=([%w%/%.=_-]+)") do
	        --print ( "cookie: "   , k, " = " , v )
	        t[k] = v 
	    end

	    return t 
	else
		return nil
	end
end





