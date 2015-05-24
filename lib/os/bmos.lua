--BMOS Library 

lib = loadfile("lib/os/lib.lua")()
xml = lib.load("xml.lua")

--Retrieve custom settings, or default. 
bmos = {xml.all("/config-user.xml")}

if not bmos then
	bmos = {xml.all("/config.xml")}
end