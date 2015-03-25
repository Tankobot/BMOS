os.loadAPI("codec.lua")
codec = _G["codec.lua"]

--CCI Image Designer 
term.clear()
term.setCursorPos(1,1)
for i=0,15 do 
    term.setBackgroundColor(2^i)
    term.write(" ")
end
print(">")
term.setCursorPos(1,2)
term.setCursorBlink(true)

while true do 
    local curX,curY = 1,1
	local Event = {} 
	local Etype 
	Etype,Event[1],Event[2],Event[3] = os.pullEvent() 
	if Etype == "mouse_click" then 
		if (Event[3] == 1) and (Event[2] <= 16) then 
			if Event[1] == 1 then 
				term.setBackgroundColor(2^(Event[2]-1)) 
			else 
				term.setTextColor(2^(Event[2]-1)) 
			end
		else
			term.setCursorPos(Event[2],Event[3])
		end
	elseif (Etype == "key") and (Event[1] == 29) then
		term.clear()
		term.setCursorPos(1,1)
		return 
	elseif Etype == "char" then
		curX,curY = term.getCursorPos() 
		term.write(tostring(Event[1]))
		--term.setCursorPos(curX,curY)
	end
end
