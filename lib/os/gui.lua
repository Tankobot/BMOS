--[[
Title: Graphical User Interface API 
Description: A generic API that can be used in order to build a simple to complex user interface and handle events associated with such. 
--]]

assert(term, "The gui library requires the term library to be loaded.")

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
		id = #self.obj+1,
		x = x,
		y = y,
		l = l,
		h = h,
		
		bg = colors.white,
		fg = colors.black,
		cc = colors.yellow,
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

local function set(self, id, bg, fg, cc) --Allows for the setting of a gui object. 
	self.obj[id].bg = bg
	self.obj[id].fg = fg
	self.obj[id].cc = cc --CC stands for Click Color. 
end

local function setText(self, id, text, x, y)
	local obj = self.obj[id]
	obj.text = text 
	obj.tx = x
	obj.ty = y
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
	for i=self.lastid, 1, -1 do 
		local obj = self.obj[i]
		if obj then
			if ((obj.x <= event[3]) and (obj.x+obj.l-1 >= event[3])) and ((obj.y <= event[4]) and (obj.y+obj.h-1 >= event[4])) then
				obj.click = true
				alarm = os.startTimer(wait)
				self.timeID[alarm] = obj.id
				return true, obj.id
			end
		end
	end
end

local function checkTime(self, alarm)
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

local function center()
	local x = term.getSize()/2
	local y = term.getSize()/2
	x = math.floor(x)
	y = math.floor(y)
	return x, y
end

--[[]]--

local gui = {
	createSet = createSet,
	drawLayers = drawLayers,
	center = center
}

return gui