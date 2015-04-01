--[[
Title: Task Manager API 
Description: For ease of task manager functions when programming. 
--]]

local function current(newTask)
	coroutine.yield("admin", "current", newTask)
end

local function listGet()
	local info = coroutine.yield("admin", "listGet")
	return info
end

local function garbage()
	coroutine.yield("admin", "garbage")
end

local function add(func, name)
	coroutine.yield("admin", "add", func, name)
end

local function run(coro, ...)
	coroutine.yield("admin", "run", coro, ...)
end

local function prun(coro, ...)
	coroutine.yield("admin", "prun", coro, ...)
end

local function addR(func, name, ...)
	coroutine.yield("admin", "addR", func, name, ...)
end

nativeExit = exit

local function exit()
	coroutine.yield("admin", "exit")
end

local function event(...)
	event = {...}
end

nativeLoadstring = loadstring 

local function loadstring(block)
	coroutine.yield("admin", "loadstring", block)
end

nativeError = error

local function error(message)
	coroutine.yield("admin", "error", message)
end

local function setCall(bool)
	coroutine.yield("admin", "setCall", bool)
end

local function setMaster(masterName)
	coroutine.yield("admin", "master", masterName)
end 

local function transfer(...)
	os.queueEvent("transfer", ...)
end

local task = {
	current = current, 
	listGet = listGet,
	garbage = garbage, 
	add = add,
	run = run,
	prun = prun, 
	addR = addR, 
	exit = exit,
	event = event, 
	loadstring = loadstring, 
	error = error,
	setCall = setCall,
	setMaster = setMaster,
	transfer = transfer
}

return task
