
module("_register" , package.seeall )

--[[
call: reg?usr=xxx&pwd=xxx
--]]

function func()

	--加上content_type, 浏览器访问的时候，不会产生下载行为
	if game_config.BROWSE_DEBUG then
		ngx.header.content_type = 'text/plain'
	end


	local args = mylib.getRequestUriArgs()
	local action = args.act

	--[[
	for k, v in pairs (args) do
		print( k , v )
	end
	--]]

	local usr = args.usr or ""
	local pwd = args.pwd or ""

	mylib.checkUserAccNameValidity( usr , action )
	mylib.checkPasswordValidity( pwd , action )

	local bMysql = true
	--操作的 table
	local table_name = game_config.TABLE_NAME.ACCOUNT
	
	--[[
	--mysql 注册
	--是否重名:
	local cmd = string.format( "select 1 from %s where user_acc='%s' limit 1" , table_name, usr )
	local res, sqlstate = mylib.dbQuery( cmd , bMysql )
	--用户已经存在
	if #res > 0 then
		mylib.errorMsg( msg_text.msgByID(  "UESR_EXIST" ) , action )
	end

	--插入
	local cmd =  string.format( "insert into %s values( %d, '%s','%s')" ,  table_name , 0, usr, pwd )
	local res, sqlstate = mylib.dbQuery( cmd , bMysql )

	if not res then
		mylib.errorMsg( msg_text.msgByID(  "DB_OP_FAILED" ) , action )
	end
	

	--]]

	local key_account_user = string.format("%s:%s" , table_name, usr ) --玩家账号
	--exists key     
	--返回个数 1， 或 0
	local res , err = mylib.dbQuery( "exists" , nil,  key_account_user )
	--用户已经存在
	if res == 1 then
		mylib.errorMsg( msg_text.msgByID(  "UESR_EXIST" ) , action )
	end


	--创建用户
	local key_script  = 'register_account'
	local cmd_argvs = {
		key_script , 4 ,
		game_config.KEY_TBL_ACCOUNT_AUTOINCR ,  key_account_user , 
		game_config.TABLE_KEYS.ACCOUNT.USER_ID , game_config.TABLE_KEYS.ACCOUNT.PASSWORD  ,
		-------------------------
		mylib.genCryptPassword( pwd ) , --密码加密
	}
	mylib.logRedisLuaScript( unpack(cmd_argvs) )

	local res , err = mylib.dbQuery( "evalsha"  , nil, unpack(cmd_argvs)  )	
	if not res then
		--尝试删除 写入的数据
		mylib.dbQuery( "del" , nil,  key_account_user )

		mylib.errorMsg( msg_text.msgByID(  "REGISTER_FAILED" ) , action )
	end
	
	--注册成功，直接登录
	local _login = require("_login")
	_login.func()

end


