

module("msg_text") --package.seeall

local LANG_ID = 2
local msgs = {
	ILLEGAL_REQUEST 	= { "illegal request" , "非法请求"  } , -- 
	ILLEGAL_USER_NAME 	= { "illegal user name" , "用户名不合法"  } , -- 
	ILLEGAL_PASSWORD 	= { "illegal password" , "密码不合法"  } , -- 
	UESR_EXIST 			= { "user exist" , "用户已存在" } ,
	USER_NOT_EXIST		= { "user not exist" , "用户不存在" } ,
	DB_CONNECT_ERR 		= { "db Connect Err" , "数据库连接错误" } ,
	DB_OP_FAILED		= { "db operation failed" , "数据库操作失败" } ,
	USER_NOT_FOUND		= { "user not found" , "用户没找到" } ,
	USR_OR_PWD_INCORRECT= { "user or pwd incorrect" , "用户名或密码错误" } ,
	REGISTER_FAILED		= { "register failed" , "用户注册失败"} ,
	GET_USERINFO_FAILED		= { "get userinfo failed" , "用户数据获取失败"} ,

}


function msgByID( ID )
	return msgs[ ID ][LANG_ID]
end




