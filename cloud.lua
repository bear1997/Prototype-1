--[cloud start]--
cloudClass = Core.class(Sprite)

local Misc = require("helper/misc")

function cloudClass:init()	
	self:addChild(Bitmap.new(Texture.new("g_background/cloud" .. tostring(math.random(3)) .. ".png")))
	self:setY(math.random(10, 200 - self:getHeight()))
	self:setX(320)
	self.isCleaned = false
	
	self:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
	self:addEventListener(Event.REMOVED_FROM_STAGE, self.onRemovedFromStage, self)
end

function cloudClass:onEnterFrame(event)	
	local cloudSpeed = 30
	self:setX(self:getX() - cloudSpeed * event.deltaTime)
	
	if Misc.isOverbound(self) then
		local removeEvent = Event.new("REMOVE_CHILD")
		removeEvent.obj = self
	    stage:dispatchEvent(removeEvent)
	end
end

function cloudClass:onRemovedFromStage(event)
	print("clean up cloud")
	self:removeEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
end

--[cloud end]--