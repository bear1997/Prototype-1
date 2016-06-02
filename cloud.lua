--[cloud start]--
cloudclass = Core.class(Sprite)

local cloud = {}
 

function cloudclass:init()	
	cloud = Bitmap.new(Texture.new("background/cloud" .. tostring(math.random(3)) .. ".png"))	
	cloud:setY(10)
	cloud:setX(320)
	stage:addChild(cloud)
	self:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
end

function cloudclass:onEnterFrame(event)
	local cloudspeed = 30
	local x = cloud:getX() - cloudspeed * event.deltaTime
	cloud:setX(x)
	if cloud:getX() < 0-cloud:getWidth() then
		cloud:setX(320)
	end
end


--[cloud end]--