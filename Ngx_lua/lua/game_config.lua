

module("game_config") --package.seeall

--[[BROWSE_DEBUG 已经关闭，init.lua 中会对  BROWSE_DEBUG＝true 赋值 ]]
BROWSE_DEBUG=false

SERVER_PRIVATE_KEY = "server private key"
SERVER_PASSWORD_KEY = "server password key"

--各个 表的名字
TABLE_NAME = { 
	ACCOUNT = 			"tbl_account" ,
  USER_INFO =     "tbl_userInfo" ,
}

--各个表中的 字段
TABLE_KEYS = {
  ACCOUNT = { 
                USER_ACCOUNT  = "user_acc" ,
                PASSWORD      = "password" ,
                USER_ID       = "user_id" ,
            } ,
  USER_INFO = {
                  GOLD        = "gold" ,
                  GEM         = "gem" ,
              }
}

--返回数据，可能返回什么字段
TABLE_RESP_KEY = {
	USER_ID 		  = TABLE_KEYS.ACCOUNT.USER_ID ,
	LOGIN_TIME 		= "login_time" , 
	TOKEN 			= "token" , 
}

--其他 key 的名字定义
KEY_TBL_ACCOUNT_AUTOINCR = TABLE_NAME.ACCOUNT .. "_autoincr"



--action 名字
TABLE_ACTION_KEY = {
	reg		= { name="reg"    , module="_register"   } ,
	login = { name="login"  , module="_login"      } ,
}

--支持的数据库名字
TABLE_ALL_DB_NAMES = { "mysql" , "redis" }


--[[
 ngx.STDERR
  ngx.EMERG
  ngx.ALERT
  ngx.CRIT
  ngx.ERR   --nginx 
  ngx.WARN
  ngx.NOTICE
  ngx.INFO
  ngx.DEBUG
--]]
 





