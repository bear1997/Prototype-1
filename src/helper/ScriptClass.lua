-- One of the core class, manage the overall story path

local Slaxml = require "lib/slaxml/slaxml"
require "lib/luautf8/utf8"
--package.loadlib("lib/luautf8/lua-utf8.dll", "len")

local CONST = require "src/res/constants"
local TEX = require "src/res/textures"
local MiscClass = require "src/helper/MiscClass"
local SceneClass = require "src/helper/SceneClass"

local ScriptClass = {}

ScriptClass.xml, ScriptClass.parser, ScriptClass.doc = nil, nil, nil

NodeList = {}
local tempTable, currName = {}, ""

BgFade, TextList = nil, {}
Text1, Text2, Name1, Name2 = nil, nil, nil, nil
Box1, Face1, Box2, Face2 = nil, nil, nil, nil
CurrText, CurrName, CurrBox, CurrFace = nil, nil, nil
local boxNum = 1

local currId = nil
local currLen, currNode, currText, currIndex, toUpdateText, skipFrame, skipFrameNum, skipFrameNumOld = 1, nil, "", 1, false, 5, 5, 5
local textIndex, totalHeight, isRefresh, isTouched = 1, 40, false, false
local canContinueScript, currChoseChar = true, 0
CurrSceneState = 0

-- Call this first before use the ScriptClass
function ScriptClass.setup()
	skipFrameNumOld = skipFrameNum
	stage:addEventListener(Event.TOUCHES_END, ScriptClass.onTouchesEnd)
	
	ScriptClass.readFile("lang/zh_CN/prologue.xml")
	ScriptClass.initDialogAssets()
end

-- Detect the input to switch between lines
function ScriptClass.onTouchesEnd(event)
	if CurrSceneState == CONST.SCENE_CHOOSE_CHARS then
		local x, y = event.touch.x, event.touch.y
		local vertx, verty = {}, {}
		--[[
		for i = 1,4 do			
			if SHeroes[i]:hitTestPoint(event.touch.x, event.touch.y) then
				currChoseChar = i				
			end
		end]]
		vertx = { 0, 360, 360, 0 }
		verty = { 0, 0, 64, 192 }
		if MiscClass.checkPointInShape(4, vertx, verty, x, y) then
			currChoseChar = 1
		end
		
		vertx = { 0, 360, 360, 0 }
		verty = { 192, 64, 256, 380 }
		if MiscClass.checkPointInShape(4, vertx, verty, x, y) then
			currChoseChar = 2
		end
		
		vertx = { 0, 360, 360, 0 }
		verty = { 380, 256, 444, 576 }
		if MiscClass.checkPointInShape(4, vertx, verty, x, y) then
			currChoseChar = 3
		end
		
		vertx = { 0, 360, 360, 0 }
		verty = { 576, 444, 640, 640 }
		if MiscClass.checkPointInShape(4, vertx, verty, x, y) then
			currChoseChar = 4
		end
		print("currChoseChar: "..currChoseChar)
		if currChoseChar ~= 0 then
			canContinueScript = true
			ScriptClass.continueScript()
		end
	end
	
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

-- Reset all the background texts to empty string
function ScriptClass.refreshText()
	if CurrSceneState == CONST.SCENE_DIALOG_BG then
		for i = 1, #TextList do
			if TextList[i] ~= nil then
				TextList[i]:setText("")
			end
		end
		totalHeight = 40
		isRefresh = false
		textIndex = 1
		toUpdateText = true
	elseif CurrSceneState == CONST.SCENE_DIALOG_CHAR then
		Text1:setText("")
		Text2:setText("")
	end	
end

-- Update both the text of characters dialog and background dialog, showing the text frame by frame
function ScriptClass.updateText()
	if toUpdateText == true	then
		if CurrSceneState == CONST.SCENE_DIALOG_BG then
			if TextList[textIndex] ~= nil then
			
			end		
		
			if TextList[textIndex] == nil then
				TextList[textIndex] = TextWrap.new("", 320, nil, nil, TTFont.new("fonts/Kai_Ti_GB2312.ttf", 19), 19)
			
				if totalHeight + TextList[textIndex]:getHeight(currNode.text) + 20 > 640 then
					isRefresh = true				
				else
					currText = currNode.text
				
					TextList[textIndex]:setTextColor(CONST.COLOR_WHITE)
					TextList[textIndex]:setPosition(26, totalHeight)
				
					totalHeight = totalHeight + TextList[textIndex]:getHeight(currNode.text) + 20
				end
			elseif currText == "" then
				if totalHeight + TextList[textIndex]:getHeight(currNode.text) + 20 > 640 then
					isRefresh = true
				else
					currText = currNode.text
				
					TextList[textIndex]:setTextColor(CONST.COLOR_WHITE)
					TextList[textIndex]:setPosition(26, totalHeight)
			
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
		elseif CurrSceneState == CONST.SCENE_DIALOG_CHAR then
			if currLen == 1 then
				print("times")
				if boxNum == 1 then
					CurrText = Text1					
					CurrFace = Face1
					CurrName = Name1
					CurrBox = Box1
				else
					CurrText = Text2
					CurrFace = Face2
					CurrName = Name2
					CurrBox = Box2
				end
				
				if currNode.char == "others" then
					--CurrFace:setAlpha(0)
					SceneClass.hide(CurrFace)
				elseif currNode.char == "knightM" then
					CurrFace:setTexture(TEX.KNIGHT_M_FACE_NORMAL_100)
					SceneClass.show(CurrFace)
				end
				
				SceneClass.show(CurrBox)
				CurrName:setText(currNode.name)
			end
			
			if skipFrame <= 0 then
				CurrText:setText(currNode.text:utf8sub(1, currLen))
				currLen = currLen + 1
				skipFrame = skipFrameNum
			end
		
			if currLen >= currNode.text:utf8len() + 1 then
				--textIndex = textIndex + 1
				--currIndex = currIndex + 1
				currLen = 1
				toUpdateText = false
				
				if boxNum == 1 then
					boxNum = 2
				else
					boxNum = 1
				end
			end
			skipFrame = skipFrame - 1
		end
	end
end

-- Core method to continue the overall game story
function ScriptClass.continueScript()
	if NodeList[currId].branch ~= nil then
		if currChoseChar == 0 then
			SceneClass.hideDialogChar()
			SceneClass.hideDialogBg()
			ScriptClass.refreshText()
			
			SceneClass.chooseChars()
			
			canContinueScript = false
			CurrSceneState = CONST.SCENE_CHOOSE_CHARS
		else			
			SceneClass:hideChooseChars()
			
			currId = NodeList[currId].nextId[currChoseChar]
			currNode = NodeList[currId]
			toUpdateText = true
			
			if currNode.name == nil then
				--print("go into dialog bg sp")
				SceneClass:showDialogBg()
				CurrSceneState = CONST.SCENE_DIALOG_BG
			else
				--print("go into dialog char sp")
				SceneClass:showDialogChar()
				CurrSceneState = CONST.SCENE_DIALOG_CHAR
			end
		end
	elseif NodeList[currId].branch == nil then
		if NodeList[currId].battle ~= nil then
			SceneClass.hideDialogChar()
			SceneClass.hideDialogBg()
			ScriptClass.refreshText()
			
			SceneClass.showBattleMode()
			
			canContinueScript = false
			CurrSceneState = CONST.SCENE_BATTLE
		elseif NodeList[currId].battle == nil then
			if NodeList[currId].name == nil and NodeList[NodeList[currId].nextId[1]].name ~= nil then
				--print("go into char")
				ScriptClass.refreshText()
				SceneClass.hideDialogBg()
				SceneClass.showDialogChar()
			elseif NodeList[currId].name ~= nil and NodeList[NodeList[currId].nextId[1]].name == nil then
				--print("go into bg")
				ScriptClass.refreshText()
				SceneClass.hideDialogChar()
				SceneClass.showDialogBg()
			end
		
			currId = NodeList[currId].nextId[1]
			currNode = NodeList[currId]
			toUpdateText = true
		
			if currNode.name == nil then
				--print("go into dialog bg")
				--SceneClass:hideDialogChar()
				--SceneClass:showDialogBg()
				CurrSceneState = CONST.SCENE_DIALOG_BG
			else
				--print("go into dialog char")
				--SceneClass:hideDialogBg()
				--SceneClass:showDialogChar()
				CurrSceneState = CONST.SCENE_DIALOG_CHAR
			end
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

-- Add current node to the current table
function ScriptClass.addNode(obj)
	--print(obj.text)
	NodeList[obj.id] = obj
end

-- Parse the corresponding attribute to be appended to current node
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
		elseif value == "name" then
			currName = value
		elseif value == "char" then
			currName = value
		elseif value == "textType" then
			currName = value
		elseif value == "isKey" then
			currName = value
		elseif value == "battle" then
			currName = value
		end
	elseif name == "VALUE" then
		if currName == "nextId" then
			tempTable.nextId = MiscClass.split(value, ",")			
		elseif currName == "branch" then
			tempTable.branch = MiscClass.split(value, ",")			
		elseif currName == "name" then
			tempTable.name = value
		elseif currName == "char" then
			tempTable.char = value
		elseif currName == "textType" then
			tempTable.textType = value
		elseif currName == "isKey" then
			tempTable.isKey = value
		elseif currName == "battle" then
			tempTable.battle = value
		end
		--currName = ""
	end
end

-- Call the continueScript method by end of the xml file, a.k.a entry point
function ScriptClass.closeElement(name, nsURI)
	if name == "map" then
		ScriptClass.addNode(tempTable)
		
		stage:addEventListener(Event.ENTER_FRAME, ScriptClass.updateText)
		
		currId = "ID_1723255651"
		ScriptClass.continueScript()
	end
end

-- Perform the actual read process of xml file
function ScriptClass.readFile(path)
	ScriptClass.xml = io.open(path):read("*all")

	ScriptClass.parser = Slaxml:parser {
		attribute = ScriptClass.attribute,
		closeElement = ScriptClass.closeElement
	}
	
	ScriptClass.parser:parse(ScriptClass.xml)
end

function ScriptClass.initDialogAssets()
	Box1 = Bitmap.new(Texture.new("graphics/ui/dialogue/paper-dialog_test.png"))
	Box1:setPosition(132, 340)
	Box1:setVisible(false)
	
	Face1 = Bitmap.new(TEX.CASTER_F_FACE_NORMAL_100)
	Face1:setPosition(20, 350)
	Face1:setVisible(false)
	
	Text1 = TextWrap.new("", 200, nil, nil, TTFont.new("fonts/Kai_Ti_GB2312.ttf", 19), 19)
	Text1:setScale(1)
	Text1:setTextColor(CONST.COLOR_BLACK)
	Text1:setPosition(147, 365)
	
	Name1 = TextField.new(TTFont.new("fonts/Kai_Ti_GB2312.ttf", 19), "")
	Name1:setTextColor(CONST.COLOR_WHITE)
	Name1:setPosition(47, 365)
	
	Box2 = Bitmap.new(Texture.new("graphics/ui/dialogue/paper-dialog_test.png"))
	Box2:setScaleX(-1)
	Box2:setPosition(230, 490)
	Box2:setVisible(false)
	
	Face2 = Bitmap.new(TEX.CASTER_F_FACE_NORMAL_100)	
	Face2:setScaleX(-1)
	Face2:setPosition(340, 500)
	Face2:setVisible(false)
	
	Text2 = TextWrap.new("", 200, nil, nil, TTFont.new("fonts/Kai_Ti_GB2312.ttf", 19), 19)
	Text2:setScale(1)
	Text2:setTextColor(CONST.COLOR_BLACK)
	Text2:setPosition(22, 515)
	
	Name2 = TextField.new(TTFont.new("fonts/Kai_Ti_GB2312.ttf", 19), "")
	Name2:setTextColor(CONST.COLOR_WHITE)
	Name2:setPosition(260, 515)
	
	BgFade = Bitmap.new(TEX.BG_FADE)
end

return ScriptClass
