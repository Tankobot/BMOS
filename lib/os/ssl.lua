--Library used for ssl communication. 

local function mod_pow(base, exponent, modulus)
	local c=1
	for e_prime=1, exponent do
		c=(c*base)%modulus
	end
	return c
end

local ssl = {
	mod_pow = mod_pow,
}

return ssl