--[[
  _  __                    _
 | |/ /                   | |
 | ' / ___ _ __ _ __   ___| |
 |  < / _ \ '__| '_ \ / _ \ |
 | . \  __/ |  | | | |  __/ |
 |_|\_\___|_|  |_| |_|\___|_|

ASCII art generated with: 
http://patorjk.com/software/taag/
--]]

--Load Task Manager Library 
local task = dofile("lib/os/task.la")
local nper = peripheral
peripheral = dofile("kernel/peripheral.lua")

local driver = {
	nil
}

--Setup Kernel Library 
local kernel = {}

function kernel.inject(thread, var)
	
end

function kernel.kill(thread)
	
end

function kernel.requestPermission(priv, sms)
	
end

function kernel.loadDriver(func)
	
end
--==

--Main Loop 
while true do
	--TODO kernel
end

return nil