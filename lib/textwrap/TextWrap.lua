--[[
*************************************************************
* This script is developed by Arturs Sosins aka ar2rsawseen, http://appcodingeasy.com
* Feel free to distribute and modify code, but keep reference to its creator
*
* TextWrap object splits string into multiple lines by provided width.
* You can also specify line spacing and alignment modes : left, right, center and justify
* It is completely compatible with existing TextField object methods
*
* For more information, examples and online documentation visit: 
* http://appcodingeasy.com/Gideros-Mobile/Creating-multi-line-text-fields-in-Gideros-Mobile
**************************************************************
]]--

TextWrap = gideros.class(Sprite)

function TextWrap:init(text, width, align, linespace, font, fontSize)
	--argument check
	if not align then align = "left" end
	if not linespace then linespace = 2 end
	if not font then font = nil end
	
	--internal settings
	self.textColor = 0x000000
	self.letterSpacing = 0.6
	self.text = text
	self.align = align
	self.width = width
	self.lineSpacing = linespace
	self.font = font
	self.fontSize = fontSize
	
	self:setText(text)
end

function TextWrap:getHeight(text)
	return math.ceil(text:utf8len() * self.fontSize / self.width) * (self.lineSpacing + self.fontSize)
end

function TextWrap:setText(text)
	self.text = text
		
	--remove previous lines
	local childCount = self:getNumChildren()
	if childCount > 0 then
		for i = 0, childCount-1 do
			self:removeChildAt(childCount-i)
		end
	end
	
	--some calculations
	
	local test = TextField.new(self.font, self.text)
	test:setLetterSpacing(self.letterSpacing) --print("self.width: "..self.width)
	--local textWidth = test:getWidth() --print("textWidth: "..textWidth)
	--local letterCount = text:len() --print("letterCount: "..letterCount)	
	--local letterChunks = math.floor(letterCount/(textWidth/self.width)) print("letterChunks: "..letterChunks)
	--local iters = math.ceil(letterCount/letterChunks) print("iters: "..iters)
	local letterChunks = math.floor(self.width / self.fontSize) --print("letterChunks: "..letterChunks)
	--local iters = math.ceil(textWidth/self.width) --print("iters: "..iters)
	local iters = math.ceil(self.text:utf8len() * self.fontSize / self.width) --print("iters: "..iters)
	--local newstr, replaces = text:gsub("\n", "\n") --print("replaces: "..replaces)
	
	local height = 0
	local last = 1
	local totalBreak = 0
	for i = 1, iters do
		--local part = text:sub(last, last+letterChunks-1) print("part: "..part)		
		local part = text:utf8sub(last, last+letterChunks-1)
		
		--local len = part:len()
		local len = part:utf8len()		
		
		local lastSpace = 0
		local newLine = false
		local startStr, endStr = part:find("\n")
		if startStr ~= nil then
			lastSpace = startStr - 1
			last = last + 1
			newLine = true
		end
		if lastSpace == 0 then
			--finding last space
			for i = 1, len do
				if part:find(" ", -i) ~= nil then
					lastSpace = ((len-i)+1)
					break
				end
			end
		end
		if lastSpace > 0 and i ~= iters then
			last = last + lastSpace
			--part = part:sub(1, lastSpace)
			part = part:utf8sub(1, lastSpace)
			--print("execute")
			lastSpace = 0
		else			
			last = last + letterChunks			
		end		
		
		local line = TextField.new(self.font, part)
		--print(line:getText())
		if line.enableBaseLine then --GiderosCodingEasy hack
			line:enableBaseLine()
		end
		line:setLetterSpacing(self.letterSpacing)
		line:setTextColor(self.textColor)
		
		if self.align == "left" or (newLine and self.align == "justify") then
			self:addChild(line)
			line:setPosition(0, height)
		elseif self.align == "right" then
			self:addChild(line)
			line:setPosition(self.width - line:getWidth(), height)
		elseif self.align == "center" then
			self:addChild(line)
			line:setPosition((self.width - line:getWidth())/2, height)
		elseif self.align == "justify" then
			local diff = self.width - line:getWidth()
			--if no difference or last line
			if diff == 0 or i == iters then
				self:addChild(line)
				line:setPosition(0, height)
			else
				local res, spaceCount = part:gsub(" ", "")
				local newLine = TextField.new(self.font, res)
				newLine:setLetterSpacing(self.letterSpacing)
				diff = self.width - newLine:getWidth()
				local eachSpace = diff/(spaceCount-1)
				local lastPos = 0
				for wordString in part:gmatch("[^%s]+") do 
					local word = TextField.new(self.font, wordString)
					if word.enableBaseLine then --GiderosCodingEasy hack
						word:enableBaseLine()
					end
					word:setLetterSpacing(self.letterSpacing)
					word:setTextColor(self.textColor)
					self:addChild(word)
					word:setPosition(lastPos, height)
					lastPos = lastPos + word:getWidth() + eachSpace
				end
			end
		end
		height = height + line:getHeight() + self.lineSpacing
	end
end

function TextWrap:getText()
	return self.text
end

function TextWrap:setTextColor(color)
	self.textColor = color
	for i = 1, self:getNumChildren() do
		local sprite = self:getChildAt(i)
		sprite:setTextColor(color)
	end
end

function TextWrap:getTextColor()
	return self.textColor
end

function TextWrap:setLetterSpacing(spacing)
	self.letterSpacing = spacing
	for i = 1, self:getNumChildren() do
		local sprite = self:getChildAt(i)
		sprite:setLetterSpacing(spacing)
	end
end

function TextWrap:getLetterSpacing()
	return self.letterSpacing
end

function TextWrap:setAlignment(align)
	self.align = align
	self:setText(self.text)
end

function TextWrap:getAlignment()
	return self.align
end

function TextWrap:setWidth(width)
	self.width = width
	self:setText(self.text)
end

function TextWrap:getWidth()
	return self.width
end

function TextWrap:setLineSpacing(linespace)
	self.lineSpacing = linespace
	self:setText(self.text)
end

function TextWrap:getLineSpacing()
	return self.lineSpacing
end

function TextWrap:setFont(font)
	self.font = font
	self:setText(self.text)
end

function TextWrap:getFont()
	return self.font
end