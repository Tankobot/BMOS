--[[
Title: Infinite* Precision Library (IPL) 
Description: A pure lua implementation 
of a bit crunching library, that works 
up to numbers of unknown amounts. 
--]]

local Ntype = type
function type(a)
	if (Ntype(a)=="table") and (a["type"]) then
		return a["type"]
	else
		return Ntype(a)
	end
end

--[[lua-users.org/wiki/CopyTable]]--
local function deepcopy(orig)
	local orig_type = type(orig)
	local copy
	if orig_type == 'table' then
		copy = {}
		for orig_key, orig_value in next, orig, nil do
			copy[deepcopy(orig_key)] = deepcopy(orig_value)
		end
		setmetatable(copy, deepcopy(getmetatable(orig)))
	else -- number, string, boolean, etc
		copy = orig
	end
	return copy
end

--Arithmetic Operators

local function add(a, b, dig)

end

local function sub(a, b, dig)

end

local function mul(a, b)

end

local function div(a, b)

end

local function unm(a)

end

local function mod(a, b, dig)

end

local function pow(a, b, dig)

end

local function concat(a, b)

end

--Equivalence Comparison Operators

local function eq(a, b)

end

local function lt(a, b)

end

local function le(a, b)

end

--Other Methods

local function call(a)

end

local function m_tostring(a)

end

local function m_len(a)

end

--Number Creation

local function int(a)
	if type(a)=="int" then
		return deepcopy(a)
	end
	a = tostring(a)
	local num = {}
	for i=1, (a:len()+13-(a:len()%13)) do
		num[i] = string.sub(a, 13*i-12, 13*i)
	end
	local tab = {
		type = "int",
		unpack(num),
	}
	local meta = {
		--Arithmetic Operators
		__add = add,
		__sub = sub,
		__mul = mul,
		__div = div,
		__unm = unm,
		__mod = mod,
		__pow = pow,
		__concat = concat,
		--Equivalence Comparison Operators
		__eq = eq,
		__lt = lt,
		__le = le,
		--Other Methods
		__call = call,
		__tostring = m_tostring,
		__len = m_len,
	}
	setmetatable(tab, meta)
end

--Declare Library Table

local ipl = {
	--Arithmetic Operators
	add = add,
	sub = sub,
	mul = mul,
	div = div,
	unm = unm,
	mod = mod,
	pow = pow,
	concat = concat,
	--Equivalence Comparison Operators
	eq = eq,
	lt = lt,
	le = le,
	--Other Methods
	call = call,
	m_tostring = m_tostring,
	m_len = m_len,
	--Number Creation
	int = int,
}

return ipl
