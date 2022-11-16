module( "asyncRequest" , package.seeall )

local url = require("socket.url")
local dispatch = require("dispatch")
local http = require("socket.http")
dispatch.TIMEOUT = 10

handler = dispatch.newhandler("coroutine")

local nthreads = 0

-- get the status of a URL using the dispatcher
function getstatus(link)
    local parsed = url.parse(link, {scheme = "file"})
    --[[
    for k,v in pairs( parsed ) do
        print (k,v)
    end
    ]]
    if parsed.scheme == "http" or parsed.scheme == "https" then
        nthreads = nthreads + 1
        handler:start(function()
            local response_body = {}

            local r, c, h, s = http.request{
                method = "GET",
                url = link,
                create = handler.tcp ,
                proxy = "https://192.168.1.4:9090",

                sink = ltn12.sink.table(response_body),
            }
            if r and c == 200 then
                io.write('\t', link, '\n')
            else
                io.write('\t', link, ': ', tostring(c), '\n')
            end

            print("Response body:")

            if type(response_body) == "table" then
                --print(table.concat(response_body))
            else
                print("Not a table:", type(response_body))
            end

            nthreads = nthreads - 1
        end)
    end
end


function exec()
    --getstatus( "https://uat-public-ubiservices.ubi.com/v2/profiles/sessions" )
    getstatus( "https://github.com/ericjjj/coursera" )
    while nthreads > 0 do
        print ( "handler:step()" )
        handler:step()
    end
end




