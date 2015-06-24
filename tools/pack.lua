--[[
Title: Bots Packager 
Description: Pretty self explanatory. 
--]]

local arg = {...}
local _input = arg[1]
local _output = arg[2]
local pkg = {}

assert(fs, "fs library not loaded")
assert(type(_input)=="string", "input is not a string")
assert(type(_output)=="string", "output is not a string")

local level = {}
local dir

while (#level > 0) do
	dir = level[#level]
	
end

return pkg