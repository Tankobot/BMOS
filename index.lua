--File index 

local arg = {...}
if arg[2] then 
	arg[2] = "/tree/"..arg[2]
else
	arg[2] = ""
end
local PATH = "Tankobot/BMOS/"..arg[1]..arg[2]

local BMOS = {
	data = {
		startup = {
			"main.lua",
		},
	},
	lib = {
		os = {
			"argSorter.lua",
			"codec.lua",
			"gui.lua",
			"net.lua",
			"task.lua",
		},
	},
	tools = {
		"CCIedit.lua",
		"login.lua",
		"startup",
		"sudo.lua",
		"taskManager",
		"trampoline.lua",
	},
	"index.lua",
	"install.lua",
	"README.md",
}

return BMOS, PATH