-- Class for cloud in background

local TEX = require "src/res/textures"
local Misc = require "src/helper/MiscClass"

CloudClass = Core.class(Sprite)

function CloudClass:init()	
	--self:addChild(Bitmap.new(Texture.new("graphics/background/cloud" .. tostring(math.random(3)) .. ".png")))
	self:addChild(Bitmap.new(TEX["CLOUD_"..math.random(3)]))
	self:setY(math.random(10, 320 - self:getHeight()))
	self:setX(360)
	self.isCleaned = false
	
	self:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
	self:addEventListener(Event.REMOVED_FROM_STAGE, self.onRemovedFromStage, self)
end

function CloudClass:onEnterFrame(event)	
	local cloudSpeed = 30
	self:setX(self:getX() - cloudSpeed * event.deltaTime)
	
	if Misc.isOverbound(self) then
		local removeEvent = Event.new("REMOVE_CHILD")
		removeEvent.obj = self
	    stage:dispatchEvent(removeEvent)
	end
end

function CloudClass:onRemovedFromStage(event)
	self:removeEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
end
