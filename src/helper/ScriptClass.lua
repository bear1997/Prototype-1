local Slaxml = require "lib/slaxml/slaxml"
require "lib/luautf8/utf8"
--package.loadlib("lib/luautf8/lua-utf8.dll", "len")

local CONST = require "src/helper/constants"
local MiscClass = require "src/helper/MiscClass"
local SceneClass = require "src/helper/SceneClass"

local ScriptClass = {}

ScriptClass.xml, ScriptClass.parser, ScriptClass.doc = nil, nil, nil

NodeList = {}
local tempTable, currName = {}, ""

BgFade, TextFade = nil, nil
local textField, textField2 = nil, nil
local box, face, box2, face2 = nil, nil, nil, nil
local boxNum = 3

local currId = nil
local currLen, currBox, currNode, currText, currIndex, toUpdateText, skipFrame, skipFrameNum, skipFrameNumOld = 1, nil, nil, "", 1, false, 5, 5, 5
local textIndex, totalHeight, isRefresh, isTouched = 1, 40, false, false
local canContinueScript = true
TextList = {}

function ScriptClass.setup()
	skipFrameNumOld = skipFrameNum
	stage:addEventListener(Event.TOUCHES_END, ScriptClass.onTouchesEnd)
end

function ScriptClass.onTouchesEnd(event)
	if canContinueScript == true then
		if toUpdateText == true then
			skipFrameNum = 1	
		else
			skipFrameNum = skipFrameNumOld
			
			if currNode.nextId ~= nil then
				ScriptClass.continueScript()
			end
		end
	end		
end

function ScriptClass.refreshText()
	for i = 1, #TextList do
		if TextList[i] ~= nil then
			TextList[i]:setText("")
		end
	end
	totalHeight = 40
	isRefresh = false
	textIndex = 1
	toUpdateText = true
end

function ScriptClass.updateText()
	if toUpdateText == true	then
		if TextList[textIndex] ~= nil then
			
		end		
		
		if TextList[textIndex] == nil then
			TextList[textIndex] = TextWrap.new("", 320, nil, nil, TTFont.new("fonts/Kai_Ti_GB2312.ttf", 19), 19)
			
			if totalHeight + TextList[textIndex]:getHeight(currNode.text) + 20 > 640 then
				isRefresh = true				
			else
				currText = currNode.text
				
				TextList[textIndex]:setTextColor(CONST.COLOR_WHITE)
				TextList[textIndex]:setPosition(20, totalHeight)
				
				totalHeight = totalHeight + TextList[textIndex]:getHeight(currNode.text) + 20
			end
		elseif currText == "" then
			if totalHeight + TextList[textIndex]:getHeight(currNode.text) + 20 > 640 then
				isRefresh = true
			else
				currText = currNode.text
				
				TextList[textIndex]:setTextColor(CONST.COLOR_WHITE)
				TextList[textIndex]:setPosition(20, totalHeight)
			
				totalHeight = totalHeight + TextList[textIndex]:getHeight(currNode.text) + 20
			end
		end
		
		if isRefresh == false and skipFrame <= 0 then
			TextList[textIndex]:setText(currNode.text:utf8sub(1, currLen))
			currLen = currLen + 1
			skipFrame = skipFrameNum
		end
		
		if currLen >= currNode.text:utf8len() + 1 then
			textIndex = textIndex + 1
			currIndex = currIndex + 1
			currLen = 1
			currText = ""
			toUpdateText = false
		end
		skipFrame = skipFrame - 1
		
		if isRefresh == true then
			ScriptClass.refreshText()
		end
	end
end

function ScriptClass.continueScript()
	if NodeList[currId].branch ~= nil then
		SceneClass.chooseChars()
		canContinueScript = false
	elseif NodeList[currId].branch == nil then
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
		tempTable.text = value:gsub("\n", "")
	elseif name == "ID" then
		if currId == nil then
			currId = value
		end
		tempTable.id = value
	elseif name == "NAME" then
		if value == "nextId" then
			currName = value
		elseif value == "branch" then
			currName = value
		end
	elseif name == "VALUE" then
		if currName == "nextId" then
			tempTable.nextId = MiscClass.split(value, ",")			
		elseif currName == "branch" then
			tempTable.branch = MiscClass.split(value, ",")			
		end
		--currName = ""
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
	
	ScriptClass.xml = io.open(path):read("*all")
	SakuOrb:hideAllOrb()
	ScriptClass.parser = Slaxml:parser {
		attribute = ScriptClass.attribute,
		closeElement = ScriptClass.closeElement
	}
	
	ScriptClass.parser:parse(ScriptClass.xml)
end

return ScriptClass
