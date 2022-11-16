
module( "asyncCurl" , package.seeall )

local curl = require('cURL')
local m = curl.multi()


function request ( url , writeFunc , finishFunc , headers , post_data )
    print("query " , url ) 
    local easy = curl.easy()
        :setopt_url( url )
        :setopt_writefunction( writeFunc )

    --easy:setopt( curl.OPT_HEADERFUNCTION , headerFunc )

    easy:setopt(curl.OPT_SSL_VERIFYHOST, 0)
    easy:setopt(curl.OPT_SSL_VERIFYPEER, 0)
    easy:setopt(curl.OPT_FOLLOWLOCATION,1);  --是否抓取跳转后的页面
    --easy:setopt(curl.OPT_PROXY, "https://127.0.0.1:9090");
    --easy:setopt(curl.OPT_NOSIGNAL, 1)

    if headers then
        easy:setopt_httpheader( headers )
    end

    if post_data then
        easy:setopt(curl.OPT_POSTFIELDS, post_data );
    end


    --easy:perform():close()

    easy.finishFunc = finishFunc

    m:add_handle(easy)
end


function step()

    -- LUA ERROR: [string "scripts/asyncCurl.lua"]:32: attempt to compare number with boolean
    local _n , _ = m:perform()
    if _n > 0 then
        --print( "mwait" )
        --m:wait()
    end
    h, ok, err = m:info_read()
    if h~= 0 then
        print ( "code: " , h:getinfo_response_code() )

        if ok then
            h.finishFunc()
        else
            print( err:name() , err:no() )
        end
        h:close()
    end
end

function test_task()
    local t_res = {} ;
    request ( 'http://github.com' , function(buffer)
                --print("----") ;
                --print(buffer)
                table.insert( t_res , buffer )
            end ,
            function()  print( 'github done' )  end
        )
end

function test_task2()
    local t_res = {} ;
    -- 'baidu.com' 会先跳转
    request ( 'http://baidu.com' , function(buffer)
            --print("----") ;
            --print(buffer)
            table.insert( t_res , buffer )
        end ,
        function()  print( 'baidu done' )  end
    )
end



