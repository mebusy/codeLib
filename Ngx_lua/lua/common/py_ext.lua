

module( "py_ext" , package.seeall )

--string 库 -------------------------------------

--python 风格的 string.split
function string:split(sSeparator, nMax, bRegexp)
	assert(sSeparator ~= '')
	assert(nMax == nil or nMax >= 1)

	local aRecord = {}

	if self:len() > 0 then
		local bPlain = not bRegexp
		nMax = nMax or -1

		local nField, nStart = 1, 1
		local nFirst,nLast = self:find(sSeparator, nStart, bPlain)
		while nFirst and nMax ~= 0 do
			aRecord[nField] = self:sub(nStart, nFirst-1)
			nField = nField+1
			nStart = nLast+1
			nFirst,nLast = self:find(sSeparator, nStart, bPlain)
			nMax = nMax-1
		end
		aRecord[nField] = self:sub(nStart)
	end

	return aRecord
end
--测试
local t_test = string.split('/usr/local/bin/a.txt', '/' )
for i,v in ipairs( t_test ) do
	print( "扩展测试 string.split:" , " ", v) 
end

string.join = function ( t , sep )
	return table.concat( t , sep )
end
--test
local test_path =string.join( t_test, "/" )
print( "扩展测试 string.jon : " , test_path )



----------------- end string 库 --------------------------------

------ start math 库 ----------------------------------------
math.minPOTLargerThan = function ( x )
    --return math.pow( 2 , math.ceil( math.log(x) / math.log(2) ) )
    local bit= require("bit")
    x = math.ceil(x)
    
    local x0 = x
    local n2p = x
    while x > 0 do
        n2p = x
        x = bit.band( x, x-1 )
    end
    
    return x0 == n2p and n2p or n2p*2
end

------ end math 库 --------------------------------------------



----- start os.path 库 ----------------------------------
py_ext.os = {}
py_ext.os.path = {}

--os.path.split 
py_ext.os.path.split = function ( path )
	--Split a pathname.  Returns tuple "(head, tail)" where "tail" is everything after the final slash.  
	--Either part may be empty.
	local _path, _file = string.match( path , "(.-)([^\\/]-%.?([^%.\\/]*))$")
	return _path, _file
end
local _path , _file = py_ext.os.path.split( test_path ) 
print( "扩展测试 py_ext.os.path.split : " ,  _path, "  " ,_file ) 


-- from penlight
local is_windows = false
local sub = string.sub

local other_sep
local sep , dirsep
if is_windows then
    sep = '\\'; 
    other_sep = '/'
    dirsep = ';'
else
    sep = '/'
    dirsep = ':'
end


local function at(s,i)
    return sub(s,i,i)
end

py_ext.os.path.splitext = function(P)
    local P = P or ""
    local i = #P
    local ch = at(P,i)
    while i > 0 and ch ~= '.' do
        if ch == sep or ch == other_sep then
            return P,''
        end
        i = i - 1
        ch = at(P,i)
    end
    if i == 0 then
        return P,''
    else
        return sub(P,1,i-1),sub(P,i)
    end
end

local _name , _ext = py_ext.os.path.splitext( _file )
print( "扩展测试 py_ext.os.path.splitext : " ,  _name, "  " , _ext )


--- is this an absolute path?.
-- @string P A file path
py_ext.os.path.isabs = function(P)
    --assert_string(1,P)
    local P = P or ""
    if is_windows then
        return at(P,1) == '/' or at(P,1)=='\\' or at(P,2)==':'
    else
        return at(P,1) == '/'
    end
end

py_ext.os.path.join = function (p1,p2,...)
    --assert_string(1,p1)
    --assert_string(2,p2)
    local p1 = p1 or ""
    local p2 = p2 or ""

    if select('#',...) > 0 then
        local p = py_ext.os.path.join(p1,p2)
        local args = {...}
        for i = 1,#args do
            --assert_string(i,args[i])
            p = py_ext.os.path.join(p,args[i])
        end
        return p
    end
    if py_ext.os.path.isabs(p2) then return p2 end
    local endc = at(p1,#p1)
    if endc ~= sep and endc ~= other_sep and endc ~= "" then
        p1 = p1 .. sep
    end
    return p1 .. p2
end

print( "扩展测试 py_ext.os.path.join : " , py_ext.os.path.join( _path, _name , _ext ) )

-------- end os.path 库 --------------------------------




