--This is the coroutine execution program for bmos. 
--[[Rundown(Psuedocode)
Initialize permissions table 
	Permisions control variable access. 
Initialize coroutine table 
	Generate new environment table for each 
Define corunner commands 
	Add metamethods for interacting with coroutine envirnonments 
Load main coroutine with admin permissions 
Set new environment for main coroutine 
Take commands from running coroutines 
--]]

local perm = {
	main = {
		file = true,
		requestPerm = true,
		addPermLevel = true,
		addPerm = true,
		inject = true,
		addThread = true,
		addPerm = true,
		remPerm = true,
		clean = true,
	},
}

local threads = {}

local envs = {
	main = {},
}

local function checkPerm(perm)
	return perm[threads[current]][perm]
end

local current

local resume = coroutine.resume
local function qresume(...)
	resume(threads[current], ...)
end

local run = {}

function run.requestPerm(name)
	if not checkPerm("requestPerm") then
		return qresume("Permission denied")
	end
	if not perm.main[name] then
		return qresume("Permission does not exist")
	end
	term.clear()
	term.setCursorPos(1, 1)
	print("Program \""..current.."\" is requestion permission \""..name.."\"")
	print("Allow access? (y/n)")
	local input = string.lower(io.read())
	if input=="y" then
		run.addPerm(current, name)
	elseif input=="n" then
		run.remPerm(current, name)
		return qresume("User denied")
	end
end

function run.addPermLevel(name, set)
	if not checkPerm("addPermLevel") then
		return qresume("Permission denied")
	end
	perm[name] = set
end

function run.addPerm(cor, name)
	if not checkPerm("addPerm") then
		return qresume("Permission denied")
	end
	perm[cor][name] = true
end

function run.remPerm(cor, name)
	if not checkPerm("remPerm") then
		return qresume("Permission denied")
	end
	perm[cor][name] = false
end

function run.inject(func)
	if not checkPerm("inject") then
		return qresume("Permission denied")
	end
	func()
end

function run.addThread(name, func, permLevel)
	if not checkPerm("addThread") then
		return qresume("Permission denied")
	end
	if not perm[permLevel] then 
		return qresume("Permission level does not exist")
	end
	if threads[name] then
		return qresume("Thread already exists")
	end
	local cor = coroutine.create(func)
	threads[name] = func
end

function run.clean()
	if not checkPerm("clean") then
		return qresume("Permission denied")
	end
	for i, v in pairs(threads) do
		if coroutine.status(v)=="dead" then
			threads[i] = nil
		end
	end
end

local empty = {}
local gmeta = {
	__index = function(index)
		if envs[current][index] then 
			if envs[current][index]==empty then
				return
			else
				return envs[current][index]
			end
		else
			return _G[index]
		end
	end,
	__newindex = function(index, value)
		if value or value==false then
			envs[current][index] = value
		else
			envs[current][index] = empty
		end
	end,
	__metatable = true
}

setmetatable(_G, gmeta)

local function nget(tab, index) --Build in better alternative later
	if tab==_G then
		return tab[index]
	else
		return rawget(tab, index)
	end
end
local function nset(tab, index, value)
	if tab==_G then
		tab[index] = value
	else 
		rawset(tab, index, value)
	end
end
local nrawg, nraws = rawget, rawset
rawget, rawset = nil, nil

--Time to actually start doing things! 

local main = loadfile(...)
run.addThread("main", main, "base")

while true do
	break
end