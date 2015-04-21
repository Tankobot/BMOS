-- ##############################
-- #                            #
-- #  Message Transfer Library  #
-- #                            #
-- ##############################

local net = {}
local modem

local function wrap(side)
	net.modem = side
	modem = side
end

local function open(startPort, endPort)
	assert(net.modem, "A modem must be wrapped to the net library.")
	local s
	if startPort <= endPort then 
		s = 1
	else
		s = -1
	end
	for i=startPort, endPort, s do
		modem.open(i)
	end
end

--TODO