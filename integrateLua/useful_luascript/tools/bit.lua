--Bit operations for lua
--李寒松

--[[
local P = {}
bit = P
local M = {__index = _G}
setmetatable(P,M)
setfenv(1,P)


mData = {}
for i = 1 , 32 do  
	mData[i] = 2 ^ (32-i)  
end

int_min = -2147483647 - 1
int_max = 2147483647
uint_max = 4294967295

local function _s2u(arg)
	local var = math.floor(arg)
	assert(var>=int_min and var<=uint_max)
	if(var < 0)then
		var = uint_max + var + 1
	end
	return var
end

local function _u2s(arg)
	local var = math.floor(arg)
	assert(var>=int_min and var<=uint_max)
	if(var > int_max)then
		var = int_min + (var - (int_max + 1))
	end
	return var
end

-- 10进制转2进制
local function _d2b(arg)
	local var = _s2u(arg)
	local ret = {}
	for i = 1 , 32 do
		if var >= mData[i] then
			ret[i] = 1
			var = var - mData[i]
		else
			ret[i] = 0
		end
	end
	return ret
end

-- 2进制转10进制 (转出的值始终是无符号整形)
local function _b2d(var)
	local ret = 0 
	for i = 1 , 32 do
		if var[i] == 1 then
			ret = ret + 2^(32-i)
		end
	end
	return ret
end

-- 与
function band(a,b)
	local v1 = _d2b(a)
	local v2 = _d2b(b)  
	local n = {}
	for i = 1, 32 do
		if (v1[i] == 0 or v2[i] == 0)  then  
			n[i] = 0
		else
			n[i] = 1 
		end
	end
	return _u2s(_b2d(n))
end

-- 或
-------------------------------------------------
function bor(a,b)
	local v1 = _d2b(a)
	local v2 = _d2b(b)
	local n = {}
	for i = 1 , 32 do  
		if (v1[i] == 1 or v2[i] == 1) then
			n[i] = 1
		else
			n[i] = 0
		end
	end
	return _u2s(_b2d(n))
end

-- 异或
-------------------------------------------------
function bxor(a,b)
	local v1 = _d2b(a)
	local v2 = _d2b(b)
	local n = {}
	for i = 1 , 32 do  
		if (v1[i] ~= v2[i]) then
			n[i] = 1
		else
			n[i] = 0
		end
	end
	return _u2s(_b2d(n))
end

-- 取反
-------------------------------------------------
function bnot(a)
	local n = _d2b(a)
	for i = 1 , 32 do  
		if (n[i] == 0) then
			n[i] = 1
		else
			n[i] = 0
		end
	end
	return _u2s(_b2d(n))
end

-- 左移
-------------------------------------------------
function lshift(a,b)
	local m = math.floor(b)
	if(m>31 or m<0)then
		return 0
	end
	local v = _d2b(a)
	local n = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,}
	if(m==31)then
		n[1] = v[32]
		return _u2s(_b2d(n))
	end
	if(m==0)then
		return _u2s(_b2d(v))
	end
	for i = 1 , 32-m do  
		n[i] = v[i + m]
	end
	return _u2s(_b2d(n))
end

-- 逻辑右移
-------------------------------------------------
function rshift(a,b)
	local m = math.floor(b)
	if(m>31 or m<0)then
		return 0
	end
	local v = _d2b(a)
	local n = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,}
	if(m==31)then
		n[32] = v[1]
		return _u2s(_b2d(n))
	end
	if(m==0)then
		return _u2s(_b2d(v))
	end
	for i = 1 , 32-m do  
		n[i + m] = v[i]
	end
	return _u2s(_b2d(n))
end

-- 算数右移
-------------------------------------------------
function arshift(a,b)
	local m = math.floor(b)
	local v = _d2b(a)
	local s = v[1]
	local n = {s,s,s,s,s,s,s,s,s,s,s,s,s,s,s,s,s,s,s,s,s,s,s,s,s,s,s,s,s,s,s,s,}
	if(m>31 or m<0)then
		return _u2s(_b2d(n))
	end
	if(m==31)then
		n[32] = v[1]
		return _u2s(_b2d(n))
	end
	if(m==0)then
		return _u2s(_b2d(v))
	end
	for i = 1 , 32-m do  
		n[i + m] = v[i]
	end
	return _u2s(_b2d(n))
end


return bit

--]]

--optimized performance for bit operation
--qibinyi,2015.09.16

--caution: only a few bit operations , which used in our game ,  were implemented 

module ("bit", package.seeall)

function lshift( num , nbit )
    num = math.floor(num)
    nbit = math.floor(nbit)
    --不考虑越界
    return num * math.pow( 2, nbit )
end

function rshift( num , nbit )
    num = math.floor(num)
    nbit = math.floor(nbit)
    --不考虑越界
    local n = math.floor( num / math.pow( 2, nbit ))
    if num < 0 then
        n = math.floor( 0x80000000 /math.pow( 2, nbit-1 ) + n)
    end
    return n
end

function bnot( num , nbit )
    return -num -1
end

local t_and =
{
    { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 },
    { 0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1 },
    { 0,0,2,2,0,0,2,2,0,0,2,2,0,0,2,2 },
    { 0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3 },
    { 0,0,0,0,4,4,4,4,0,0,0,0,4,4,4,4 },
    { 0,1,0,1,4,5,4,5,0,1,0,1,4,5,4,5 },
    { 0,0,2,2,4,4,6,6,0,0,2,2,4,4,6,6 },
    { 0,1,2,3,4,5,6,7,0,1,2,3,4,5,6,7 },
    { 0,0,0,0,0,0,0,0,8,8,8,8,8,8,8,8 },
    { 0,1,0,1,0,1,0,1,8,9,8,9,8,9,8,9 },
    { 0,0,2,2,0,0,2,2,8,8,10,10,8,8,10,10 },
    { 0,1,2,3,0,1,2,3,8,9,10,11,8,9,10,11 },
    { 0,0,0,0,4,4,4,4,8,8,8,8,12,12,12,12 },
    { 0,1,0,1,4,5,4,5,8,9,8,9,12,13,12,13 },
    { 0,0,2,2,4,4,6,6,8,8,10,10,12,12,14,14 },
    { 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15 },
}

local t_or =
{
    { 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15 },
    { 1,1,3,3,5,5,7,7,9,9,11,11,13,13,15,15 },
    { 2,3,2,3,6,7,6,7,10,11,10,11,14,15,14,15 },
    { 3,3,3,3,7,7,7,7,11,11,11,11,15,15,15,15 },
    { 4,5,6,7,4,5,6,7,12,13,14,15,12,13,14,15 },
    { 5,5,7,7,5,5,7,7,13,13,15,15,13,13,15,15 },
    { 6,7,6,7,6,7,6,7,14,15,14,15,14,15,14,15 },
    { 7,7,7,7,7,7,7,7,15,15,15,15,15,15,15,15 },
    { 8,9,10,11,12,13,14,15,8,9,10,11,12,13,14,15 },
    { 9,9,11,11,13,13,15,15,9,9,11,11,13,13,15,15 },
    { 10,11,10,11,14,15,14,15,10,11,10,11,14,15,14,15 },
    { 11,11,11,11,15,15,15,15,11,11,11,11,15,15,15,15 },
    { 12,13,14,15,12,13,14,15,12,13,14,15,12,13,14,15 },
    { 13,13,15,15,13,13,15,15,13,13,15,15,13,13,15,15 },
    { 14,15,14,15,14,15,14,15,14,15,14,15,14,15,14,15 },
    { 15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15 },
}


function band( num1 , num2 )
    local bDoubleNegative = false
    if num1 <0 and num2 <0 then
        bDoubleNegative = true
    end
    
    
    num1 = string.format("%X" , num1 )
    num2 = string.format("%X" , num2 )
    
    local t1 = {}
    string.gsub( num1 , '[0-9A-F]' , function(w) table.insert(t1, 1, tonumber(w,16) ) end )
    local t2 = {}
    string.gsub( num2 , '[0-9A-F]' , function(w) table.insert(t2, 1, tonumber(w,16) ) end )
    
    --print( "aaaa" , num1, num2 )
    --[[
    	for i=1,#t1 do
     print ( i, t1[i])
    	end
    	for i=1,#t2 do
     print ( i, t2 [i])
    	end
    	--]]
    local sum = ""
    local n = math.max( #t1, #t2 )
    for i=1,n do
        local val1 = t1[i] or 0
        local val2 = t2[i] or 0
        local result = t_and[ val1+1 ] [ val2+1 ] or 0
        --print ( val1 , val2 , result  )
        sum = string.format( "%X%s" , result , sum  )
    end
    
    if bDoubleNegative then
        sum = string.gsub( sum , "^F+" , "")
        return  -(math.pow( 16, string.len(sum) )-(tonumber(sum, 16) or 0) )
        else
        return tonumber(sum, 16)
    end
end


function bor( num1 , num2 )
    local bDoubleNegative = false
    if num1 <0 or num2 <0 then
        bDoubleNegative = true
    end
    
    
    num1 = string.format("%X" , num1 )
    num2 = string.format("%X" , num2 )
    
    local t1 = {}
    string.gsub( num1 , '[0-9A-F]' , function(w) table.insert(t1, 1, tonumber(w,16) ) end )
    local t2 = {}
    string.gsub( num2 , '[0-9A-F]' , function(w) table.insert(t2, 1, tonumber(w,16) ) end )
    
    --print( "aaaa" , num1, num2 )
    --[[
    	for i=1,#t1 do
     print ( i, t1[i])
    	end
    	for i=1,#t2 do
     print ( i, t2 [i])
    	end
    	--]]
    local sum = ""
    local n = math.max( #t1, #t2 )
    for i=1,n do
        local val1 = t1[i] or 0
        local val2 = t2[i] or 0
        local result = t_or[ val1+1 ] [ val2+1 ] or 0
        --print ( val1 , val2 , result  )
        sum = string.format( "%X%s" , result , sum  )
    end
    
    --print("bbbb" , sum)
    
    if bDoubleNegative then
        sum = string.gsub( sum , "^F+" , "")
        return  -(math.pow( 16, string.len(sum) )-(tonumber(sum, 16) or 0))
        else
        return tonumber(sum, 16)
    end
end




