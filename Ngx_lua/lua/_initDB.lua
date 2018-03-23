
module("_initDB" , package.seeall )


--初始化 mysql db
function func()

    --加上content_type, 浏览器访问的时候，不会产生下载行为
    if game_config.BROWSE_DEBUG then
        ngx.header.content_type = 'text/plain'
    end

    --初始化 数据库 表
    local bMysql = true

    --mysql 测试 必须在发送 content 之前
    local table_name = game_config.TABLE_NAME.ACCOUNT 
    local auto_inc_start = 10000000
    --[[
    user_id 64位整数  主键 自增
    user_acc 唯一  UNIQUE KEY idx_usr_name (user_acc)
    password
    --]]
    local cmd = string.format("CREATE table IF NOT EXISTS %s ( \
                        user_id BIGINT not null AUTO_INCREMENT,  \
                        user_acc CHAR(16), \
                        password CHAR(16), \
                            PRIMARY KEY(user_id), UNIQUE KEY idx_usr_name (user_acc) \
                        ) AUTO_INCREMENT = %d" ,  table_name, auto_inc_start ) 
    local res,  sqlstate  = mylib.dbQuery( cmd , bMysql )


    -- end 初始化 数据库 表 ------------------------

    mylib.okMsg( string.format( "create table '%s' successfully" , table_name ) )

end

