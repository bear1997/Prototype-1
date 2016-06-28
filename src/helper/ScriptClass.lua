local Slaxml = require "lib/slaxml/slaxml"
require "lib/luautf8/utf8"
--package.loadlib("lib/luautf8/lua-utf8.dll", "len")

local CONST = require "src/helper/constants"
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

function ScriptClass.setup()
	skipFrameNumOld = skipFrameNum
	stage:addEventListener(Event.TOUCHES_END, ScriptClass.onTouchesEnd)
end

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
	end	
end

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
					--[[
					if currNode.char == "others" then
						Face1:setAlpha(0)
					elseif currNode.char == "knightM" then
						Face1 = Bitmap.new(TEX.KNIGHT_M_FACE_NORMAL_100)
					end]]
				else
					CurrText = Text2
					CurrFace = Face2
					CurrName = Name2
					--[[
					if currNode.char == "others" then
						Face2:setAlpha(0)
					elseif currNode.char == "knightM" then
						Face2 = Bitmap.new(TEX.KNIGHT_M_FACE_NORMAL_100)
					end]]
				end
				
				if currNode.char == "others" then
					--CurrFace:setAlpha(0)
					SceneClass.hide(CurrFace)
				elseif currNode.char == "knightM" then
					CurrFace:setTexture(TEX.KNIGHT_M_FACE_NORMAL_100)
					SceneClass.show(CurrFace)
				end
				
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

function ScriptClass.continueScript()
	if NodeList[currId].branch ~= nil then
		if currChoseChar == 0 then			
			SceneClass:hideDialogChar()
			SceneClass:hideDialogBg()
			ScriptClass:refreshText()			
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
		if NodeList[currId].name == nil and NodeList[NodeList[currId].nextId[1]].name ~= nil then
			--print("go into char")
			SceneClass.hideDialogBg()
			SceneClass.showDialogChar()
		elseif NodeList[currId].name ~= nil and NodeList[NodeList[currId].nextId[1]].name == nil then
			--print("go into bg")
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
		--[[
		if boxNum == 3 then
			currId = NodeList[currId].nextId[1]
			currNode = NodeList[currId]
			toUpdateText = true
			CurrSceneState = CONST.SCENE_DIALOG_BG
		end]]
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
		elseif value == "name" then
			currName = value
		elseif value == "char" then
			currName = value
		elseif value == "textType" then
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
		end
		--currName = ""
	end
end

function ScriptClass.closeElement(name, nsURI)
	if name == "map" then
		ScriptClass.addNode(tempTable)
		
		stage:addEventListener(Event.ENTER_FRAME, ScriptClass.updateText)
		
		currId = "ID_1723255651"
		ScriptClass.continueScript()
	end
end

function ScriptClass.readFile(path)
	Box1 = Bitmap.new(Texture.new("graphics/ui/dialogue/paper-dialog_test.png"))
	Box1:setPosition(132, 340)
	
	Face1 = Bitmap.new(TEX.CASTER_F_FACE_NORMAL_100)
	Face1:setPosition(20, 350)
	
	Text1 = TextWrap.new("", 200, nil, nil, TTFont.new("fonts/Kai_Ti_GB2312.ttf", 19), 19)
	Text1:setScale(1)
	Text1:setTextColor(0xff0000)
	Text1:setPosition(147, 365)
	
	Name1 = TextField.new(TTFont.new("fonts/Kai_Ti_GB2312.ttf", 19), "")
	Name1:setTextColor(CONST.COLOR_WHITE)
	Name1:setPosition(47, 365)
	
	Box2 = Bitmap.new(Texture.new("graphics/ui/dialogue/paper-dialog_test.png"))
	Box2:setScaleX(-1)
	Box2:setPosition(230, 490)
	
	Face2 = Bitmap.new(TEX.CASTER_F_FACE_NORMAL_100)	
	Face2:setScaleX(-1)
	Face2:setPosition(340, 500)
	
	Text2 = TextWrap.new("", 200, nil, nil, TTFont.new("fonts/Kai_Ti_GB2312.ttf", 19), 19)
	Text2:setScale(1)
	Text2:setTextColor(0xff0000)
	Text2:setPosition(22, 515)
	
	Name2 = TextField.new(TTFont.new("fonts/Kai_Ti_GB2312.ttf", 19), "")
	Name2:setTextColor(CONST.COLOR_WHITE)
	Name2:setPosition(260, 515)
	
	BgFade = Bitmap.new(Texture.new("graphics/background/bg_fade.png"))
	
	ScriptClass.xml = io.open(path):read("*all")
	SakuOrb:hideAllOrb()
	ScriptClass.parser = Slaxml:parser {
		attribute = ScriptClass.attribute,
		closeElement = ScriptClass.closeElement
	}
	
	ScriptClass.parser:parse(ScriptClass.xml)
end

return ScriptClass
