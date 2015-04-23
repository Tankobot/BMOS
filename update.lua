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

print("Retrieving index for requested version of BMOS, or master branch.")
assert(http.get(_PATH..arg[1].."/index.lua"), "Failed to retrieve index for "..arg[1]..".")
print("Retrieved index for "..arg[1]..".")

assert(http, "The updater requires the 'http' api in order to download necessary files.")

local function download(dirTable, currentPath)
	if not dirTable then dirTable = {} end
	for i, v in pairs(dirTable) do
		if type(v) == "table" then
			local status, message = pcall(download, v, currentPath..i.."/")
			if not status then
				error(message, 0)
			end
		elseif type(v) == "string" then
			if v == "end" then
				os.queueEvent("end")
				return true
			else
				place = _PATH..arg[1]..currentPath..v
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
			local file = io.open(names[event[2]], "w")
			file:write(event[3]:readAll())
			file:close()
		elseif event[1] == "http_failure" then
			print("Failed to download file at '"..names[event[2]].."'.")
		elseif event[1] == "end" then
			return
		end
	end
end

local BMOS = loadfile("index.lua")()

if not arg[2] then arg[2] = shell.dir() end

download(BMOS, "") 
http2drive(arg[2], names)

print("BMOS finished downloading.")
print("Check above for errors. If no errors exist, BMOS should have installed correctly.")