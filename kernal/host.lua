--[[
  _  __                     _ 
 | |/ /                    | |
 | ' / ___ _ __ _ __   __ _| |
 |  < / _ \ '__| '_ \ / _` | |
 | . \  __/ |  | | | | (_| | |
 |_|\_\___|_|  |_| |_|\__,_|_|

ASCII art generated with: 
http://patorjk.com/software/taag/
--]]

--Load Task Manager Library 
local task = dofile("lib/os/task.la")
local nper = peripheral
peripheral = dofile("kernal/peripheral.lua")

local driver = {
	nil
}

--Setup Kernal Library 
local kernal = {}

function kernal.inject(thread, var)
	
end

function kernal.kill(thread)
	
end

function kernal.requestPermission(priv, sms)
	
end

function kernal.loadDriver(func)
	
end
--==

--Main Loop 
while true do
	--TODO Kernal
end

return nil