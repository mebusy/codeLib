

module("redis_scripts" , package.seeall ) 

--[[
--README
redis_scripts.raw_scripts.key 原始脚本
redis_scripts.key             sha 值
--]]


raw_scripts = {

--[[
account_user = { user_id = ... , 
                 password = ...  }
--]]

-- key_tbl_account_autoincr 
register_account = [[
  local key_tbl_account_autoincr = KEYS[1]

  --初始化 账号计数
  local auto_inc_start = 10000000
  redis.call( "setnx" , key_tbl_account_autoincr , auto_inc_start  )

  --自增 计数作为 user_id
  local user_id = redis.call( "incr" , key_tbl_account_autoincr )

  local key_account_user = KEYS[2]
  redis.call( "hmset" , key_account_user , KEYS[3] ,  user_id  ,   KEYS[4] ,  ARGV[1]   )
  
  return user_id
]] , 

login_account = [[
    local key_userinfo = KEYS[1]
    local initial_data = cjson.decode(ARGV[1])

    local res = redis.call( "exists" , key_userinfo )
    if res == 0 then
        --不存在
        redis.call( "hmset" , key_userinfo , unpack(initial_data) )
    end

    local res = redis.call( "hgetall" , key_userinfo )
    return res
]]

} ------------- end raw_scripts -------------


function register( )
    if redis_scripts.bRegisted then
        return
    end

    redis_scripts.bRegisted = true

  	for k,v in pairs( raw_scripts ) do 
  		local res, err = mylib.dbQuery( "script" , nil, "load" , v  )
  		if res == ngx.null  then
  			print ( "register lua script " , k , " failed." )
  		else
  			redis_scripts[k] = res
  			print ( "register lua script " ,  k , ":" , res )
  		end
  	end
end




