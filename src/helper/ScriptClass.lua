local Slaxml = require "lib/slaxml/slaxml"
require "lib/luautf8/utf8"
--package.loadlib("lib/luautf8/lua-utf8.dll", "len")

local MiscClass = require "src/helper/MiscClass"

local ScriptClass = {}

ScriptClass.xml, ScriptClass.parser, ScriptClass.doc = nil, nil, nil

NodeList = {}
local tempTable, currName = {}, ""

BgFade, TextFade = nil, nil
local textField, textField2 = nil, nil
local box, face, box2, face2 = nil, nil, nil, nil
local boxNum = 3

local currId = nil
local currLen, currBox, currNode, currText, currIndex, toUpdateText, skipFrame = 5, nil, nil, "", 1, false, 4

function ScriptClass.updateText()
	if toUpdateText == true	then
		if skipFrame == 0 then
			currBox:setText(currText .. currNode.text:utf8sub(1, currLen))
			--currText[currIndex] = currNode.text:utf8sub(1, currLen)
			--currBox:setText(currText)
			--print(currText..currNode.text:utf8sub(1, currLen))
			currLen = currLen + 1
			skipFrame = 5
		end
		
		if currLen == currNode.text:utf8len() then
			--table.insert(currText, currNode.text)
			currText = currText .. currNode.text .. "\n\n"
			currIndex = currIndex + 1
			currLen = 1
			toUpdateText = false
			
			if currNode.nextId ~= nil then
				ScriptClass.continueScript()
			end			
		end
		skipFrame = skipFrame - 1
	end
end

function ScriptClass.continueScript()
	--local test = "\n我喔"
	--print(test:find("\n"))
	if boxNum == 1 then	
		boxNum = 2
	elseif boxNum == 2 then
		boxNum = 1
	end
	
	if boxNum == 3 then
		currId = NodeList[currId].nextId[1]
		currBox = TextFade
		currNode = NodeList[currId]
		--currText[currIndex] = currNode.text
		toUpdateText = true
	end
end

function ScriptClass.testTable(obj)
	--print(obj.id)
	--[[
	if obj ~= nil then
		--print("not nil")
		for i, j in ipairs(obj) do
			print("in ipair")
			print(i..": "..j)
		end
	end]]
end

function ScriptClass.addNode(obj)
	--print(obj.text)
	NodeList[obj.id] = obj
end

function ScriptClass.attribute(name, value, nsURI, nsPrefix)
	if name == "TEXT" then		
		if tempTable.id ~= nil then
			--print(tempTable.id)
			ScriptClass.addNode(tempTable)
			--ScriptClass.testTable(tempTable)
		end
		tempTable = {}
		tempTable.text = value
	elseif name == "ID" then
		if currId == nil then
			currId = value
		end
		tempTable.id = value
	elseif name == "NAME" then
		if value == "nextId" then
			currName = value
		end
	elseif name == "VALUE" then
		if currName == "nextId" then
			tempTable.nextId = MiscClass.split(value, ",")
			currName = ""
		end
	end
end

function ScriptClass.closeElement(name, nsURI)
	if name == "map" then
		ScriptClass.addNode(tempTable)
		
		stage:addEventListener(Event.ENTER_FRAME, ScriptClass.updateText)
		
		ScriptClass.continueScript()
	end
end

function ScriptClass.readFile(path)
	--[[
	box = Bitmap.new(Texture.new("graphics/ui/dialogue/paper-dialog_test.png"))
	box:setPosition(132, 340)
	MiscClass.bringToFront(box)
	
	face = Bitmap.new(Texture.new("graphics/char/magician/female/face/magigirl_face_normal.png"))
	face:setPosition(20, 350)
	MiscClass.bringToFront(face)
	
	textField = TextWrap.new("我我我我我我我我我我我\n我我我我我我我我我我我\n我我我我我我我我我我我\n我我我我我我我我我我我\n我我我我我我我我我我我", 400, nil, nil, TTFont.new("fonts/Kai_Ti_GB2312.ttf", 19))
	textField:setScale(1)
	textField:setTextColor(0xff0000)
	textField:setPosition(138, 365)
	MiscClass.bringToFront(textField)
	
	box2 = Bitmap.new(Texture.new("graphics/ui/dialogue/paper-dialog_test.png"))
	box2:setScaleX(-1)
	box2:setPosition(230, 490)
	MiscClass.bringToFront(box2)
	
	face2 = Bitmap.new(Texture.new("graphics/char/magician/female/face/magigirl_face_normal.png"))	
	face2:setScaleX(-1)
	face2:setPosition(340, 500)
	MiscClass.bringToFront(face2)
	
	textField = TextWrap.new("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", 200, nil, nil, TTFont.new("fonts/Kai_Ti_GB2312.ttf", 19))
	textField:setScale(1)
	textField:setTextColor(0xff0000)
	textField:setPosition(13, 515)
	MiscClass.bringToFront(textField)]]
	
	BgFade = Bitmap.new(Texture.new("graphics/background/bg_fade.png"))
	MiscClass.bringToFront(BgFade)
	
	TextFade = TextWrap.new("", 320, nil, nil, TTFont.new("fonts/Kai_Ti_GB2312.ttf", 19), 19)	
	TextFade:setTextColor(0xff0000)
	TextFade:setPosition(20, 40)
	MiscClass.bringToFront(TextFade)
	
	ScriptClass.xml = io.open(path):read("*all")
	SakuOrb:hideAllOrb()
	ScriptClass.parser = Slaxml:parser {
		attribute = ScriptClass.attribute,
		closeElement = ScriptClass.closeElement
	}
	
	ScriptClass.parser:parse(ScriptClass.xml)
end

return ScriptClass
