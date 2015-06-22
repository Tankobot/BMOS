--Library used for SSL communication, ComputerCraft. 

local cipher = ...

local ssl = {}

--Extra Math Functions 

ssl.math = {}

function ssl.math.mod_pow(base, exponent, modulus)
	local c=1
	for e_prime=1, exponent do
		c=(c*base)%modulus
	end
	return c
end

function ssl.math.mod_gcd(a, b)
	local x,y, u,v = 0,1, 1,0
	local q, r, m, n
	while a ~= 0 do
		q, r = math.floor(b/a), b%a
		m, n = x-u*q, y-v*q
		b,a, x,y, u,v = a,r, u,v, m,n
	end
	local gcd = b
	return gcd, x, y
end

--[[local function egcd(e, t)
	local a, b, c
	if e > t then 
		a, b = e, t
	else
		a, b = t, e
	end
	while b > 1 do
		c = a%b
		a = b
		b = c
	end
	if b ~= 0 then
		return false
	else
		return a
	end
end--]]

function ssl.math.mod_inv(a, m)
	local gcd, x, y = mod_gcd(a, m)
	if gcd ~= 1 then
		return false
	else
		return x%m
	end
end

--Cryption Functions 

function ssl.genKeyPair(p, q)
	assert(type(p)=="number", "Expected #1 arg number!")
	assert(type(q)=="number", "Expected #2 arg number!")
end

function ssl.encrypt(str, key)
	
end

function ssl.decrypt(str, key)
	
end

function ssl.hash(str, salt)
	
end

--SSL Functions 

function ssl.connect(host, ip, cert)
	
end

function ssl.pull(info)
	
end

--Return Library 

return ssl