--Library used for SSL communication, ComputerCraft. 

cipher = ...

--Extra Math Functions 

local function mod_pow(base, exponent, modulus)
	local c=1
	for e_prime=1, exponent do
		c=(c*base)%modulus
	end
	return c
end

local function mod_gcd(a, b)
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

local function mod_inv(a, m)
	local gcd, x, y = mod_gcd(a, m)
	if gcd ~= 1 then
		return false
	else
		return x%m
	end
end

--Cryption Functions 

local function genKeyPair(p, q)
	assert(type(p)=="number", "Expected #1 arg number!")
	assert(type(q)=="number", "Expected #2 arg number!")
end

local function encrypt(str, key)
	
end

local function decrypt(str, key)
	
end

local function hash(str, seed)
	
end

--SSL Functions 

local function connect(host, ip, cert)
	
end

local function load(info)
	
end

--Return Library 

local ssl = {
	math = {
		mod_pow = mod_pow,
	},
	--Cryption 
	genKeyPair = genKeyPair,
	encrypt = encrypt,
	decrypt = decrypt,
	hash = hash,
	--SSL Func
	connect = connect,
	load = load,
}

return ssl