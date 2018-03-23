
module("_handleReq" , package.seeall )

--[[
call: reg?usr=xxx&pwd=xxx
--]]

function func()
	--加上content_type, 浏览器访问的时候，不会产生下载行为
	if game_config.BROWSE_DEBUG then
		ngx.header.content_type = 'text/plain'
	end


	local args = mylib.getRequestUriArgs()
	local action = args.act or ""

	--请求不存在
	if not game_config.TABLE_ACTION_KEY[action] then
		mylib.errorMsg( msg_text.msgByID(  "ILLEGAL_REQUEST" ) , action )
	end

	local m = require( game_config.TABLE_ACTION_KEY[action].module )
    m.func()
end


