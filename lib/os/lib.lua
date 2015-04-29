--[[
Library Loader
--]]

local N_load = load
local arg = {...}
local _PRE = table.remove(arg)
local _BIN = arg

local function load(path, ...)
	local f
	for i=1, #_BIN do
		if not f then
			f = loadfile(_PRE.._BIN[i]..path)
		else
			break
		end
	end
	if not f then
		f = loadfile(_PRE..path)
	end
	if not f then
		error("Library '"..path.."' can not be found.", 0)
	end
	local out = {f(...)}
	return unpack(out)
end

local function writeLib(path, info)
	local file = io.open(_PRE..path, "w")
	file:write(info)
	file:close()
end