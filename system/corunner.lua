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
	base = {
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

local current

function checkPerm(permis)
	return perm[threads[current]][permis]
end

local checkPerm = checkPerm

local resume = coroutine.resume
local function qresume(...)
	resume(threads[current], ...)
end

local run = {}

function run.requestPerm(name)
	if not checkPerm("requestPerm") then
		return qresume("Permission denied")
	end
	if not perm.base[name] then
		return qresume("Permission does not exist")
	end
	term.clear()
	term.setCursorPos(1, 1)
	print("Program \""..current.."\" is requesting permission \""..name.."\"")
	print("Allow access? (y/n)")
	local input = string.lower(io.read())
	if input=="y" then
		perm[current][name] = true
	elseif input=="n" then
		perm[current][name] = false
		return qresume("User denied")
	end
end

function run.addPermLevel(name, set)
	if not checkPerm("addPermLevel") then
		return qresume("Permission denied")
	end
	perm[name] = set
end

function run.addPerm(coro, name)
	if not checkPerm("addPerm") then
		return qresume("Permission denied")
	end
	perm[coro][name] = true
end

function run.remPerm(coro, name)
	if not checkPerm("remPerm") then
		return qresume("Permission denied")
	end
	perm[coro][name] = false
end

function run.inject(funcStr)
	if not checkPerm("inject") then
		return qresume("Permission denied")
	end
	load(funcStr)()
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
	threads[name] = coroutine.create(func)
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

local nrawg, nraws = rawget, rawset
rawget, rawset = nil, nil

setmetatable(_G, gmeta)

--Time to actually start doing things! 

local main = loadfile(...)
run.addThread("main", main, "base")

while true do
	break
end
