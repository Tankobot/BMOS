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

local bg = gui.createSet() --Setup login prompt 
local bgBack = bg:add(1, 1, x, y)
bg:set(bgBack, colors.lightBlue, nil, colors.lightBlue)

local login = gui.createSet()
local lgHello = login:add(cx-5, cy-3, 12, 3)
local userFd = login:add(cx-4, cy+1, 10, 1)
local passFd = login:add(cx-4, cy+3, 10, 1)
local go = login:add(cx-2, cy+5, 6, 1)

login:set(lgHello, colors.blue, colors.white, colors.blue) --Version
login:setText(lgHello, version, 2, 2)
login:set(userFd, nil, colors.lightGray) --User Feed
login:setText(userFd, "Username")
login:set(passFd, nil, colors.lightGray) --Pass Feed
login:setText(passFd, "Password")
login:set(go, colors.red, nil, colors.pink) --Go Button
login:setText(go, "GO", 3)

login:setF(userFd, gui.f.textBox)
login:setF(passFd, gui.f.textBox)

bg:draw()
local event
while true do --Main loop 
	login:draw()
	local temp
	local id
	event = {os.pullEvent()}
	if event[1] == "mouse_click" then
		while (type(event)=="table") and (event[1]=="mouse_click") do
			id, temp, event = login:checkSet(event)
		end
	elseif event[1] == "timer" then
		event = login:checkTime(event, 1)
		sleep(0.25)
		break
	end
	
	if (id==userFd) and (type(event)=="string") then
		
	end
end

term.setBackgroundColor(colors.black)
term.setTextColor(colors.white)
term.clear()
term.setCursorPos(1,1)
print("Loggin in.")