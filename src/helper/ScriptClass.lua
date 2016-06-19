local Slaxml = require "lib/slaxml/slaxml"

local MiscClass = require "src/helper/MiscClass"

local ScriptClass = {}

ScriptClass.xml, ScriptClass.parser, ScriptClass.doc = nil, nil, nil

NodeList = {}
local tempTable, currName = {}, ""

local textField, texta = nil, nil

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
	print(obj.text)
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
		tempTable.id = value
	elseif name == "NAME" then
		if value == "nextId" then
			currName = value
		end
	elseif name == "VALUE" then
		if currName == "nextId" then
			tempTable.nextId = value
			currName = ""
		end
	end
end

function ScriptClass.closeElement(name, nsURI)
	if name == "map" then
		ScriptClass.addNode(tempTable)
	end
end

function ScriptClass.readFile(path)
	--textField = TextWrap.new("a", 200)
	textField = TextWrap.new("我我我我我我我我我我我。\n我我我我我我我我我我我\n我我我我我我我我我我我\n我我我我我我我我我我我\n我我我我我我我我我我我", 300, nil, nil, TTFont.new("fonts/Kai_Ti_GB2312.ttf", 19))
	textField:setScale(1)
	textField:setTextColor(0xff0000)
	textField:setPosition(128, 360)
	MiscClass.bringToFront(textField)
	
	ScriptClass.xml = io.open(path):read("*all")
	
	ScriptClass.parser = Slaxml:parser {
		attribute = ScriptClass.attribute,
		closeElement = ScriptClass.closeElement
	}
	
	ScriptClass.parser:parse(ScriptClass.xml)
end

return ScriptClass
