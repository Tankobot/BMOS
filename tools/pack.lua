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

local paths = {}

--Find packaging path non-recursively. 
while true do
	local DIR = ""
	local FILE
	
	while DIR do
		
	end
	
	while FILE do
		
	end
end

--Use generated path to create file. 
local dir = {}
while (#paths > 0) do 
	dir = paths[#paths]
	
end

return pkg