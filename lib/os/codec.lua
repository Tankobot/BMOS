--BMOS Image Codec
local colorKey = {
	["0"] = colors.white,
	["1"] = colors.orange,
	["2"] = colors.magenta,
	["3"] = colors.lightBlue,
	["4"] = colors.yellow,
	["5"] = colors.lime,
	["6"] = colors.pink,
	["7"] = colors.gray,
	["8"] = colors.lightGray,
	["9"] = colors.cyan,
	["a"] = colors.purple,
	["b"] = colors.blue,
	["c"] = colors.brown,
	["d"] = colors.green,
	["e"] = colors.red,
	["f"] = colors.black
}

--Converter
local function convert(colorV)
	return colorKey[colorV]
end

--Decode String to Table
local function decode(stringFile)
	local theTable = {}
	local globalIndex = 0
	local BGV,FGV,CVV
	local lineList = {}
	local done = false
	local lineNo = 0
	local lineBegin = 0
	local lineEnd = 0
	while done == false do
		lineBegin = lineEnd+1
		if stringFile:find("\n",lineBegin) == nil then
			done = true
			lineEnd = 0
		else
			lineEnd = stringFile:find("\n",lineBegin)
		end
		lineNo=lineNo+1
		lineList[lineNo] = stringFile:sub(lineBegin,lineEnd-1)
		--print(lineList[lineNo]) --Testing
		theTable[lineNo] = {}
	end
	for i=1,#lineList do
		globalIndex = 0
		for j=1,#lineList[i]/3 do
			local globalStart = globalIndex*3+1
			BGV = lineList[i]:sub(globalStart,globalIndex*3+1)
			FGV = lineList[i]:sub(globalStart+1,globalIndex*3+2)
			CVV = lineList[i]:sub(globalStart+2,globalIndex*3+3)
			globalIndex = globalIndex+1
			--print(BGV,FGV,CVV)
			theTable[i][j] = {BGV,FGV,CVV}
		end
	end
	return theTable
end

--Encode Table to String
local function encode(tableFile)
--TODO
end

--Inefficient way of easily rendering a cc image to the screen.
local function printCCI(tableFile,x,y)
	for i=1,#tableFile do
		term.setCursorPos(x,y-1+i)
		for j=1,#tableFile[i] do
			term.setBackgroundColor(convert(tableFile[i][j][1]))
			term.setTextColor(convert(tableFile[i][j][2]))
			term.write(tableFile[i][j][3])
		end
	end
end

local codec = {
	colorkey=colorkey,
	convert=convert,
	decode=decode,
	encode=encode,
	printCCI=printCCI
}

return codec
