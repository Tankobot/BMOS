--[[
Title: Computercraft Task Manager 
Author: Tankobot 
Version: 0.1 
--]]

arg = {...}
assert(arg[1] and arg[2],"Usage: program <path> <name>")

--Open program from argument as coroutine and specify it as the master coroutine. 
masterFunc = loadfile(arg[1])


--Create the task table and add the master coroutine to it. 
local task = {}
task["master"] = coroutine.create(masterFunc)
task["masterName"] = arg[2]
task[arg[2]] = task.master


--Create admin table. 
local admin = {}

--Function to set the currently running task. 
function admin.current(newTask)
	if newTask then 
		current = newTask
	else
		return current
	end
end

--Function to get the list of currently open threads. 
function admin.listGet()
	local task_info = {}
	local count = 1
	for i, v in pairs(task) do 
		task_info[count] = i 
		count = count+1
	end
	return task_info
end

--Function to collect and delete finished/dead threads. 
function admin.garbage()
	local threads = admin.listGet()
	for i=1, #threads do 
		check = coroutine.status(task[threads[i]])
		if check == "dead" then
			task[threads[i]] = nil
		end
	end
end

--Function to add coroutines to task list. 
function admin.add(newFunc, name)
	assert(name ~= "master", "Tried to create thread with reserved name", 0)
	if not task[name] then
		task[name] = coroutine.create(newFunc)
	else
		error("A thread with name "..name.." already exists.", 0)
	end
end

--Function to run coroutines and retrieve and perform small processing on outputs. 
function admin.run(coro, ...)
	local arg = {...} 
	local result = {coroutine.resume(coro, unpack(arg))}
	local dump = table.remove(result, 1)
	local eventType = table.remove(result, 1)
	if not dump then 
		error(eventType, 0)
	end
	return eventType, result
end

--Protected version of admin.run function. 
function admin.prun(coro, ...)
	local arg = {...} 
	local result = {coroutine.resume(coro, unpack(arg))}
	local dump = table.remove(result, 1)
	local eventType = table.remove(result, 1)
	return dump, eventType, result
end

--Combined function of admin.add and admin.run. 
function admin.addR(path, name, ...)
	admin.add(path, name)
	local arg = {...}
	return admin.run(task[name], unpack(arg))
end

--Closes the task manager. 
function admin.exit()
	error("Closing task manager...", 0)
end

--Sets the current event object from an admin command. 
function admin.event(...)
	event = {...}
end

--Allows the admin to load a custom chunk. 
function admin.loadString(block)
	local f = loadstring(block)
	f()
end

--Allows the admin to turn out an error message and close the entire system. 
function admin.error(message)
	error(message, 0)
end

--Allows the admin to change how the task manager calls tasks. 
function admin.setCall(bool)
	if bool then 
		admin.call = admin.prun 
	elseif not bool then 
		admin.call = admin.run 
	else
		error("Usage: admin setCall <boolean>", 0)
	end
end

function admin.setMaster(masterName)
	assert(task[masterName], "The new master task does not exist.")
	assert(task[masterName] ~= task.master, "That task is already the master task.")
	task.masterName = masterName 
	task.master = task.masterName 
end

admin.call = admin.run


--Starting master program. 
eType, extra = admin.call(task.master, "info", "master")
admin.current("master")
while true do
	if eType == false then 
		eType, extra = admin.call(admin.master, "error", current, extra[1])
	end
	if (eType == "admin") and (current == "master") then 
		info = {admin[extra[1]](unpack(extra, 2))}
		if info then 
			eType, extra = admin.call(task.master, "admin", unpack(info))
		end
	end
	if coroutine.status(task.master) == "dead" then 
		error("Master thread is now dead.", 0)
	else
		event = {os.pullEvent()}
	end
	if current ~= "master" then 
		decision, extra = admin.call(task.master, "taskManager", current, unpack(event))
		if (decision == "true") or (not decision) then 
			if event[1] == "transfer" then 
				dump = table.remove(event, 1)
				eType, extra = admin.call(task[event[2]], "transfer", current, unpack(event))
			else
				eType, extra = admin.call(task[current], unpack(event))
			end
		elseif decision == "admin" then 
			admin[extra[1]](unpack(extra, 2))
		elseif decision == "false" then 
			eType, extra = admin.call(task[current], "false")
			if eType == "taskManager" then 
				eType = nil 
			end
		else 
			error("\""..decision.."\" is not a proper condition for event checking.", 0)
		end
	else 
		eType, extra = admin.call(task.master, unpack(event))
	end
end
