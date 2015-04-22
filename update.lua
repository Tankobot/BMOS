--[[
Title: BMOS Updater
Version: v0.1
--]] 

local _NAME = "Tankobot/BMOS/"
local _PATH = "https://raw.githubusercontent.com/".._NAME
local download
local arg = {...}
local place
local names = {}

assert(http, "The updater requires the 'http' api in order to download necessary files.")

local function download(dirTable, currentPath, statName)
	for i, v in pairs(dirTable) do
		if type(v) == "table" then
			local status, message = pcall(download, v, currentPath..i.."/")
			if not status then
				error(message, 0)
			else
				return message
			end
		elseif type(v) == "string" then
			if v == "end" then
				return true
			else
				place = _PATH..arg[1]..currentPath
				http.request(place)
				names[place] = currentPath..v
			end
		else
			error("Index formatted incorrectly, expected 'table' or 'string'. Got "..type(v), 0)
		end
	end
end

local function http2drive(path, names)
	while true do
		local event = {os.pullEvent()}
		if event[1] == "http_success" then
			--TODO
		elseif event[1] == "http_failure" then
			print("Failed to download file at '"..names[event[2]].."'.")
		end
	end
end