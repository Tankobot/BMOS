--[[
Title: Startup 
--]]

local lib = loadfile("lib/os/lib.lua")("lib/", "os/")
local task = lib.load("task.lua")
local gui = lib.load("gui.lua")
assert(colors, "Colors library required.")
assert(io, "Io library required.")

local x, y = term.getSize()
local cx, cy = gui.center()
local version = "BMOS v0.1a"

if ((x<51) or (y<19)) and not pocket then
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

local bg = gui.createSet()
local bgBack = bg:add(1, 1, x, y)
bg:set(bgBack, colors.lightBlue, nil, colors.lightBlue)

local login = gui.createSet()
local lgHello = login:add(cx-5, cy-1, cx+6, cy+1)
login:set(lgHello, colors.blue, colors.black, colors.blue)
login:setText(lgHello, version, 2, 2)

gui.drawLayers(bg, login)
os.pullEvent("char")