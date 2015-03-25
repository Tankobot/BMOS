--#lib
--[[
Title: Argument Sorting Function 
Author: Tankobot (Michael Bradley) 
--]]

local function argSorting(oldArg)
	newArg = {}
	for i=1, #oldArg do 
		--Checking for double hyphen options. 
		if string.find(oldArg[i],"%-%-")==1 then 
			option = string.sub(oldArg[i],3)
			newArg[option]=i+1
		--Checking for multiple single hyphen options. 
		elseif string.find(oldArg[i],"-")==1 then
			fullString = oldArg[i]
			for j=1, #fullString do 
				fullString = string.sub(fullString,2)
				option = string.sub(fullString,1,1)
				newArg[option]=i+1
			end
		--Assigning regular arguments to normal slots. 
		else 
			newArg[i]=oldArg[i]
		end
	end
	newArg[""] = nil
	return newArg
end

argSort = argSorting

return argSort
