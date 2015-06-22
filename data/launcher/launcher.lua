--Desktop Script
assert(lib, "Lib library not present!")
assert(bmos, "BMOS library not present!")

local gui = lib.load("gui.lua")

--[[local function icon_C(obj, event)
	local up = 
end--]]

local x, y = term.getSize()
local cx, cy = gui.center()
local bg, tx, fg = unpack(bmos.style.desktop)

local backg = {set = gui.createSet()} --Setup layer
do
	local layer = backg.set
	local desktop = layer.add(1, 1, x, y-1) --Background
	local actionBar = layer.add(1, y, x, 1) --Home Button

	layer:set(desktop, bg, tx, bg)
	layer:set(actionBar, fg, tx, fg)

	layer:setText(actionBar, ("%"):rep(x))
end

--[[while true do --Main Loop
	local event = {os.pullEvent()}
	if event[1]=="mouse_click" then
		
	end
end--]]
