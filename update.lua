--[[
Title: BMOS Updater
Version: v0.1
--]] 

local _NAME = "Tankobot/BMOS/"
local _PATH = "https://raw.githubusercontent.com/".._NAME
local download
local arg = {...}

assert(http, "The updater requires the 'http' api in order to download necessary files.")

local function download(dirTable, currentPath)
	for i, v in pairs(dirTable) do
		if type(v) == "table" then
			local status, message = download(v, currentPath..v.."/"
		elseif type(v) == "string" then
			http.request("https://raw.githubusercontent.com/"..
			"Tankobot/BMOS/"..arg[1]..currentPath)
		else
			error("Index formatted incorrectly, expected 'table' or 'string'. Got "..type(v), 0)
		end
	end
end