
module("_initRedisLua" , package.seeall )


--初始化 mysql db
function func()

    --加上content_type, 浏览器访问的时候，不会产生下载行为
    if game_config.BROWSE_DEBUG then
        ngx.header.content_type = 'text/plain'
    end

    --注册 redis 脚本
    redis_scripts.register()    

    mylib.okMsg( "register redis lua script." )

end

