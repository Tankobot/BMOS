--TEMP START

local lib = loadfile("lib/os/lib.lua")("lib/", "os/")
local task = lib.load("task.lua") --Load necessary libraries 
local gui = lib.load("gui.lua")
assert(colors, "Colors library required.")
assert(io, "Io library required.")

local x, y = term.getSize()
local cx, cy = gui.center()
local version = "BMOS v0.1a"

--TEMP END

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
local userIn
local passIn

while true do --Main loop 
	login:draw()
	local state
	local id
	
	event = event or {os.pullEvent()}
		
	if event[1] == "mouse_click" then
		id, state, event = login:checkSet(event)
		login:draw()
	elseif event[1] == "timer" then
		local condition, id = login:checkTime(event)
		if condition and (id==go) then
			break
		end
	elseif event[1] == "tab" then
		local args = login.obj[event[2]].arg or {}
		id = event[2]
		state, event = login:startF(event[2], unpack(args))
	end
	
	if (id==userFd) and (type(event)=="string") then
		userIn = event
	end
	
	if (id==passFd) and (type(event)=="string") then
		passIn = event
	end
	
	if state == "\t" then
		local idNew = id+1
		os.queueEvent("tab", idNew)
	end
	
	if state == true then
		break
	end
	
	if not ((type(event)=="table") and (event[1]=="mouse_click")) then
		event = nil
	end
end

term.setBackgroundColor(colors.black)
term.setTextColor(colors.white)
term.clear()
term.setCursorPos(1,1)
print("Logging in.")
print("User: "..(userIn or ""))--Debug
print("Pass: "..(passIn or ""))--Debug

return userIn, passIn