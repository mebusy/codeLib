

-- no more external access after this point
module( "global_data" , package.seeall ) -- 


function load_datafile ( path )
    
    local f = io.open(path, "r")
    if f then
        local data = f:read("*all")
        f:close()
        
        local t = json.decode(data)
        
        if t then
            print("读取配置文件:"  , path )
            return t
        end
        
        t = nil
    end
    
    return nil
end

function loadData()

	--获取 配置文件
	local data_folder = global_data.NGX_LUA_ROOT .. "/data"
	local f_cmd = io.popen( string.format('ls %s' ,  data_folder ) )
	while true do
		local path = f_cmd:read('*l')
		
		if path then
			
			--local _path , _file = py_ext.os.path.split(path)
			local _name , _ext = py_ext.os.path.splitext(path)
			local _path = py_ext.os.path.join( data_folder , path  )

			global_data[ _name ] = load_datafile ( _path )

		else
			break
		end
	end
	f_cmd:close()
	------------- 配置文件 -------

end






