
module("_init" , package.seeall )

--避免全局变量污染
local function func()
	--ticks 
	local DEBUG = true

	--获取 Ngx_lua 目录 --------------------------
	local ngx_lua_root 
	local i = string.find( package.path  , "/lua/%?" )

	--记录 Ngx_lua root 目录
	local global_data = require("global_data")
	global_data.NGX_LUA_ROOT = string.sub( package.path , 1, i-1  )

	local path =  global_data.NGX_LUA_ROOT
	print ("Ngx_lua root目录:" , path )

	--添加 lua 搜索 目录
	--lua common
	package.path = string.format( "%s/lua/%s/?.lua;%s" , path  , "common" , package.path )
	--lua 3rd
	package.path = string.format( "%s/lua/%s/?.lua;%s" , path  , "3rd" , package.path )

	--print( package.path )

	--------------end  Ngx_lua 目录 ----------------

	-- pre loaded module:
	--[[
		json
		game_config
		py_ext
		mylib
		msg_text
	]]

	--注意: preload module
	--common
	local json = require("json")
	local py_ext = require("py_ext") 			 --扩展-----

	--3rd
	--3rd 不是module


	--other
	local game_config=require("game_config")
	local msg_text = require("msg_text")
	
	local db_config = require("db_config")
	local mylib = require("mylib")

	require("myLog")

	-- game config 配置
	game_config.BROWSE_DEBUG=DEBUG
	
	--读取配置文件
	local global_data = require("global_data")
	global_data.loadData()

	------------------ redis脚本文件-----------
	local redis_scripts = require("redis_scripts")


	

	print( "module init.lua loaded . " )
end

func()


