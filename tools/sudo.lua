--Way to run specific programs from shell as root. 

local arg = {...}
local cdir = fs.dir()

assert(bmos, "BMOS must be installed. And/or is missing.")

local _SUDO = _G
local func = loadfile(cdir.."/"..arg[1])
bmos.logout()
io.write("Password: ")
local pass = read("*")
local check, info = pcall(bmos.login, "root", pass)

if not check then 
	error("Error: "..info, 0)
end

local funcArg = arg
table.remove(funcArg, 1)
func(unpack(funcArg))