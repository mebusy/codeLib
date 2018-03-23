
module("_login" , package.seeall )

--[[
call: login?usr=xxx&pwd=xxx
--]]

function func()

	--加上content_type, 浏览器访问的时候，不会产生下载行为
	if game_config.BROWSE_DEBUG then
		ngx.header.content_type = 'text/plain'
	end


	local args = mylib.getRequestUriArgs()
	local action = args.act


	local usr = args.usr or ""
	local pwd = args.pwd or ""

	mylib.checkUserAccNameValidity( usr , action )
	mylib.checkPasswordValidity( pwd , action )


	
	--操作的 table
	local table_name = game_config.TABLE_NAME.ACCOUNT

	--[[
	local bMysql = true
	--检查用户合法性
	local cmd = string.format( "select user_id from %s where user_acc='%s' and password='%s' limit 1" , table_name , usr , pwd )
	local res, sqlstate = mylib.dbQuery( cmd , bMysql  )	

	if (not res ) or ( #res == 0 ) then
		mylib.errorMsg(  msg_text.msgByID(  "USR_OR_PWD_INCORRECT" ) , action  )
	end
	--]]
	--[[
	for i , t in ipairs(res) do
		for k,v in pairs(t) do
			print( k, " : "  ,v )
		end
	end
	--]]
	--redis 验证
	--根据 用户账号 ，获取 密码 和 user_id 
	local res , err = mylib.dbQuery( "hmget" , nil,  string.format("%s:%s" , table_name , usr ) , 
		game_config.TABLE_KEYS.ACCOUNT.USER_ID , game_config.TABLE_KEYS.ACCOUNT.PASSWORD )
	--需要取 两个 数据
	--res[2] 是保存的 加密秘密
	if (not res ) or ( #res < 2 ) or res[2]~= mylib.genCryptPassword(pwd) then
		mylib.errorMsg(  msg_text.msgByID(  "USR_OR_PWD_INCORRECT" ) , action  )
	end

	--res[1] 保存的 用户id
	local user_id = res[1]

	local time = ngx.now() --float, milli seconds 
	local token = mylib.genToken( user_id, time )

	--处理返回表
	local t_resp = {}
	t_resp[game_config.TABLE_RESP_KEY.USER_ID] = user_id  --以后使用user_id通讯，防止被破解
	t_resp[game_config.TABLE_RESP_KEY.LOGIN_TIME] = time
	t_resp[game_config.TABLE_RESP_KEY.TOKEN] = token

	--先构建需要保存到 cookie 的表，然后保存
	mylib.save2cookie( t_resp )

	--根据user_id 取 玩家数据
	local key_tbl_userinfo  = game_config.TABLE_NAME.USER_INFO 
	local key_userinfo = string.format( "%s:%s" , key_tbl_userinfo , user_id ) 

	--玩家初始化数据, key,value , key , value 形式数组
	local initial_data = { 
		game_config.TABLE_KEYS.USER_INFO.GOLD , global_data.initial[game_config.TABLE_KEYS.USER_INFO.GOLD].VALUE ,
		game_config.TABLE_KEYS.USER_INFO.GEM ,  global_data.initial[game_config.TABLE_KEYS.USER_INFO.GEM].VALUE ,
	}

	local key_script  = 'login_account'
	local cmd_argvs = {
		key_script , 1 ,
		key_userinfo ,
		-------------------------
		json.encode( initial_data ) 
	}

	local res , err = mylib.dbQuery( "evalsha"  , nil, unpack(cmd_argvs)  )	
	if not res then
		--尝试删除 写入的数据
		mylib.dbQuery( "del" , nil,  key_userinfo )
		mylib.errorMsg( msg_text.msgByID(  "GET_USERINFO_FAILED" ) , action )
	else
		--添加用户信息数据
		t_resp[key_tbl_userinfo]={}
		for i=1, #res , 2 do
			t_resp[key_tbl_userinfo][res[i]] = res[i+1]
		end
		--所有用户信息返回
		mylib.okMsg( string.format( "verified user name: %s " , usr )  , action  , t_resp   )
	end

	--[[
	local num = tonumber(ngx.var.arg_num) or 0


	--解析  ngx.var.http_cookie
	--ngx.var.http_cookie 是字符串
	local t_cookie = {}
	if ngx.var.http_cookie then
	    local s = ngx.var.http_cookie
	    for k, v in string.gmatch(s, "(%w+)=([%w%/%.=_-]+)") do
	        t_cookie[k] = v
	    end
	end

	local t_args = ngx.req.get_uri_args()

	--参数中有uid ， 但是 t_cookie 没有 uid
	--if not t_cookie.uid and t_args.uid then


	

	ngx.say( ngx.var.http_cookie and "cookie" or "null" )

	print( "login :" , expires  , ngx.var.http_cookie )
	-- body
	--]]


end


