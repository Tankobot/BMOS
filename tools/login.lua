--[[
Title: BMOS Login Utility 
Description: Login Utility is a simple shell program used to let the OS understand who is using the computer and what priveleges they should be provided. 
--]]

arg = {...}

assert(arg[1], "User not specified.")
username = arg[1]
term.write("Password: ")
password = read("")

