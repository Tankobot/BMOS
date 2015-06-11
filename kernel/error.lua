--[[
  ______                     
 |  ____|                    
 | |__   _ __ _ __ ___  _ __ 
 |  __| | '__| '__/ _ \| '__|
 | |____| |  | | | (_) | |   
 |______|_|  |_|  \___/|_|   

ASCII art generated with: 
http://patorjk.com/software/taag/
--]]

local function handler(bool, msg, ...)
	if not bool then 
		if msg:find("attempt to call nil") then
			
		elseif msg:find("Too long without yielding") then
			
		end
	end
end

return handler