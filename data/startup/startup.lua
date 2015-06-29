--[[
Title: Startup 
--]]

local lib = loadfile("lib/os/lib.lua")("lib/", "os/")
local task = lib.load("task.lua") --Load necessary libraries 
local gui = lib.load("gui.lua")
assert(colors, "Colors library required.")
assert(io, "Io library required.")

local x, y = term.getSize()
local cx, cy = gui.center()
local version = "BMOS v0.1a"

if ((x<51) or (y<19)) and not pocket then --Check monitor size 
	write([[Screen size of 51x19 or greater 
	recommended for desktop version. 
	Continue anyway (y/n)?]])
	local re = io.read():lower()
	if re == "y" then
		print("Proceeding with normal startup...")
	elseif re == "n" then
		error("Canceling startup...", 0)
	else
		error("Unknown input, aborting startup...", 0)
	end
elseif ((x<26) or (y<20)) and pocket then
	write([[Screen size of 26x20 or greater 
	recommended for pocket version. 
	Continue anyway (y/n)?]])
	local re = io.read():lower()
	if re == "y" then
		print("Proceeding with normal startup...")
	elseif re == "n" then
		error("Canceling startup...", 0)
	else
		error("Unknown input, aborting startup...", 0)
	end
end

kernel.next("login.lua")