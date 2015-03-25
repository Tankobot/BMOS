--[[
Title: Trampoline Launcher 
Author: Tankobot (Michael Bradley) 
--]] 

local gui = os.loadlib("os/gui.lua")
local codec = os.loadlib("os/codec.lua")

local back = gui.createSet()
local icon = gui.createSet()

back:img(1,1)
bTime = back:add(1,1,4,1)
bInfo = back:add(12,1,4,1)
lbApps = back:img(12,19)
lbInfo = back:add(10,20,8,1)