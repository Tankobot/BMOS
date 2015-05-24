--[[
Title: 
Description: Pure lua xml parser. 
Supports: 
	element start
	attributes
	body
	element end
Working on:
	escape characters
Substitute:
	'\' acts as escape key. 
--]]

--Reading XML file. 

local function readAll(self)
	
end

local function readLine(self)
	
end

--Creating XML file. 

local function create(doctype)
	local tab = {}
	tab["1>type"]=doctype
	return tab
end

local function start(self, name, ...)
	local atr = {...}
	--TODO
end

--Write xml file to path or string. 
local function writeXML(path, tab)
	
end