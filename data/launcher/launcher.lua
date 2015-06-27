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
	backg.desktop = layer.add(1, 1, x, y-1) --Background
	backg.actionBar = layer.add(1, y, x, 1) --Home Button

	layer:set(backg.desktop, bg, tx, bg)
	layer:set(backg.actionBar, fg, tx, fg)

	layer:setText(backg.actionBar, ("%"):rep(x))
end

--[[while true do --Main Loop
	local event = {os.pullEvent()}
	if event[1]=="mouse_click" then
		
	end
end--]]
