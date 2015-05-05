--[[
Title: Graphical User Interface API 
Description: A generic API that can be used in order to build a simple to complex user interface and handle events associated with such. 
--]]

assert(term, "The gui library requires the term library to be loaded.")

local function check(click, obj)
	local up = (click[3] >= obj.y)
	local down = (click[3] < obj.y+obj.h)
	local left = (click[2] >= obj.x)
	local right = (click[2] < obj.x+obj.l)
	if up and down and left and right then 
		return true
	end
end

--Gui object functions. 

local function draw(self) --Redraws the screen including any changes to the gui set. 
	local term = self.term
	for id=self.lastid,1,-1 do
		local obj = self.obj[id]
		if obj then
			term.setCursorPos(obj.x,obj.y)
			if obj.click then
				term.setBackgroundColor(obj.cc)
			else
				term.setBackgroundColor(obj.bg)
			end
			term.setTextColor(obj.fg)
			diff = obj.l-#obj.text 
			if diff < 0 then
				error("Text is too long for object. ID: "..obj.id)
			end
			for i=0, obj.l-1 do
				for j=0, obj.h-1 do
					term.setCursorPos(obj.x+i, obj.y+j)
					term.write(" ")
				end
			end
			term.setCursorPos(obj.x+obj.tx-1, obj.y+obj.ty-1)
			term.write(obj.text)
		end
	end
end

local function add(self, x, y, l, h) --Allows for the addition of a new gui object into the set. 
	local id = #self.obj+1
	local button = {
		arg = {},
		f = nil,
		meta = {},
		id = #self.obj+1,
		x = x,
		y = y,
		l = l,
		h = h,
		
		bg = colors.white,
		fg = colors.black,
		cc = colors.white,
		text = "",
		tx = 1,
		ty = 1,
		click = false
	}
	if #self.obj+1>self.lastid then 
		self.lastid = #self.obj+1
	end
	self.obj[id] = button
	return id
end

local function rm(self, id) --Allows for the removal of a gui object. 
	self.obj[id] = nil
end

local function meta(self, id, key, entry)
	--TODO
end

local function set(self, id, bg, fg, cc) --Allows for the setting of a gui object. 
	assert(type(id) == "number", "Expected number id arg#1.")
	local pos = self.obj[id]
	bg = bg or pos.bg --Set color defaults.
	fg = fg or pos.fg
	cc = cc or pos.cc
	
	pos.bg = bg
	pos.fg = fg
	pos.cc = cc --CC stands for Click Color. 
end

local function setText(self, id, text, x, y)
	local obj = self.obj[id]
	obj.text = text 
	obj.tx = x or obj.tx or 1
	obj.ty = y or obj.ty or 1
end

local function timer(self, id, tID)
	self.timeID[tID]=id
end

local function repos(self, id, x, y, l, w) --Allows for the translocation of a gui object. 
	self.obj[id].x = x
	self.obj[id].y = y
	self.obj[id].l = l
	self.obj[id].h = h
end

local function clear(self) --Allows for the removal of all gui objects in a gui set without deleting the entire table itself. 
	self.obj = nil
	self.obj = {}
	self.lastid = 0
end

local function checkSet(self, event, wait) 
	assert(type(event) == "table", "Event is not a table.")
	wait = wait or 0.5
	for i=self.lastid, 1, -1 do 
		local obj = self.obj[i]
		if obj then
			if ((obj.x <= event[3]) and (obj.x+obj.l-1 >= event[3])) and ((obj.y <= event[4]) and (obj.y+obj.h-1 >= event[4])) then
				obj.click = true
				alarm = os.startTimer(wait)
				self.timeID[alarm] = obj.id
				if obj.f then 
					local feedback = {obj.f(obj, self.term, unpack(obj.arg))}
				end
				return obj.id, unpack(feedback or {})
			end
		end
	end
end

local function checkTime(self, alarm)
	assert(type(alarm) == "table", "Event/alarm is not a table.")
	local timer = alarm[2]
	local id = self.timeID[timer]
	if self.obj[id] then
		self.obj[id].click = false
		return true
	end
end

local function img(image, x, y)
	assert(image.type == "cci", "Image is not a supported format.")
	for i=1, #image do 
		for j=1, #image[i] do 
			--TODO
		end
	end
end

local function setF(self, id, func, ...)
	local obj = self.obj[id]
	if func then
		obj.f = func
		obj.arg = {...}
	else
		return obj.f
	end
end

--Preset Object Functions

local function textBox(obj, term, mask)
	local meta = obj.meta
	local typing = true
	local typed = meta.typed or {}
	local masked = meta.masked or {}
	meta.mask = mask
	meta.pre = meta.pre or obj.text
	local space = " "
	local stX = obj.x+obj.tx-1
	local stY = obj.y+obj.ty-1
	local areaX = obj.l-obj.tx+1
	local strEnd = " "
	term.setCursorBlink(true)
	term.setCursorPos(stX, stY)
	term.setBackgroundColor(obj.bg)
	term.setTextColor(meta.color or colors.black)
	while typing do
		local event = {os.pullEvent()}
		local view
		if #typed < areaX-1 then
			view = #typed
		else
			view = areaX-1
		end
		
		if event[1] == "char" then
			table.insert(typed, event[2])
		elseif event[1] == "key" then
			if event[2] == 28 then
				term.setCursorBlink(false)
				meta.typed = typed
				if not (#typed > 0) then
					obj.text = meta.pre
				else
					obj.text = table.concat(typed, nil, 1, view)..strEnd
				end
				return true, table.concat(typed)
			elseif event[2] == 14 then
				table.remove(typed)
			end
			--TODO
		elseif event[1] == "mouse_click" then
			if not check(event, obj) then
				term.setCursorBlink(false)
				meta.typed = typed
				if not (#typed > 0) then
					obj.text = meta.pre
				else
					obj.text = table.concat(typed, nil, 1, view)..strEnd
				end
				return true, event
			end
		end
		if #typed < (areaX) then
			term.setCursorPos(stX, stY)
			term.write(space:rep(areaX))
			term.setCursorPos(stX, stY)
			term.write(table.concat(typed))
		else
			term.setCursorPos(stX, stY)
			term.write(space:rep(areaX))
			term.setCursorPos(stX, stY)
			term.write(table.concat(typed, "", #typed-areaX+2))
		end
		if #typed > areaX-1 then
			strEnd = ">"
		else
			strEnd = " "
		end
	end
end

--Global GUI Functions

local function createSet(monitor) --Allows for the creation of a gui set. 
	local tab = {
		obj = {},
		timeID = {},
		draw = draw,
		add = add,
		rm = rm,
		set = set,
		setText = setText,
		move = move,
		clear = clear,
		timer = timer,
		checkSet = checkSet,
		checkTime = checkTime,
		setF = setF,
		lastid = 0
	}
	if monitor then 
		tab.term = monitor
	else
		tab.term = term
	end
	return tab
end

local function drawLayers(...)
	arg = {...}
	for i=1, #arg do 
		draw(arg[i])
	end
end

local function checkLayers(event, ...)
	local arg = {...}
	for i=#arg, 1, -1 do
		checkSet(arg[1], event)
	end
end

local function center(monitor)
	local term = monitor or term
	local x = term.getSize()/2
	local y = ({term.getSize()})[2]/2
	x = math.floor(x)
	y = math.floor(y)
	return x, y
end

--[[]]--

local gui = {
	f = {
		textBox = textBox,
	},
	createSet = createSet,
	drawLayers = drawLayers,
	center = center,
}

return gui