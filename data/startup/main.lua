--[[
Title: Startup 
--]]

local lib = dofile("lib/lib.lua")
lib.load("tskMng.lua")
lib.load("gui.lua")

local center 
do 
	local x, y = term.getSize()
	center = {math.floor(x/2), math.floor(y/2)}
	if x%2 then 
		center.x = true
	end
	if y%2 then 
		center.y = true
	end
end

local scp = term.setCursosPos
term.clear()
scp(center[1], center[2])

gui.write("Start?\nTerminate to exit.")
local event = os.pullEventRaw()
if event == "terminate" then 
	os.shutdown()
else
	term.clear()
	scp(1,1)
	print("Starting BMOS...")
	sleep(0.1)
end