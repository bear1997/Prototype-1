local Slaxml = require "lib/slaxml/slaxml"
local MiscClass = require "src/helper/MiscClass"

local ScriptClass = {}

ScriptClass.xml, ScriptClass.parser, ScriptClass.doc = nil, nil, nil

local textField, texta = nil, nil

function ScriptClass.startElement(name, nsURI, nsPrefix)
	--[[
	if texta == nil then
		textField:setText("a")
		print(name)
		texta = name
	end]]
end

function ScriptClass.attribute(name, value, nsURI, nsPrefix)
	if name == "TEXT" then
		--textField:setText(value)
	end
end

function ScriptClass.text(text)
	--[[
	if texta == nil then
		textField:setText("a")
		print(text)
		texta = text
	end]]
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
		startElement = ScriptClass.startElement,
		attribute = ScriptClass.attribute,
		text = ScriptClass.text
	}
	
	ScriptClass.parser:parse(ScriptClass.xml)
end

return ScriptClass
