GrassClass = Core.class(Sprite)

local Misc = require("helper/MiscClass")

function GrassClass:init()
	self:addChild(Bitmap.new(Texture.new("g_background/grass" .. tostring(math.random(4)) .. ".png")))
	self:setY(320 - self:getHeight())
	self:setX(320)
	self.isCleaned = false
	
	self:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
	self:addEventListener(Event.REMOVED_FROM_STAGE, self.onRemovedFromStage, self)
end

function GrassClass:onEnterFrame(event)	
	local grassSpeed = 120
	self:setX(self:getX() - grassSpeed * event.deltaTime)
	
	if Misc.isOverbound(self) then
		local removeEvent = Event.new("REMOVE_CHILD")
		removeEvent.obj = self
	    stage:dispatchEvent(removeEvent)
	end
end

function GrassClass:onRemovedFromStage(event)	
	self:removeEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
end
	