--[grass start]--
grassClass = Core.class(Sprite)

local Misc = require("helper/misc")

function grassClass:init()
	self:addChild(Bitmap.new(Texture.new("g_background/grass" .. tostring(math.random(4)) .. ".png")))
	self:setY(320 - self:getHeight())
	self:setX(320)
	self.isCleaned = false
	
	self:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
	self:addEventListener(Event.REMOVED_FROM_STAGE, self.onRemovedFromStage, self)
end

function grassClass:onEnterFrame(event)	
	local grassSpeed = 120
	self:setX(self:getX() - grassSpeed * event.deltaTime)
	
	if Misc.isOverbound(self) then
		local removeEvent = Event.new("REMOVE_CHILD")
		removeEvent.obj = self
	    stage:dispatchEvent(removeEvent)
	end
end

function grassClass:onRemovedFromStage(event)
	--print("clean up grass")
	self:removeEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
end
	
--[grass end]--