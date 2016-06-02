--[grass start]--
grassclass = Core.class(Sprite)

grass1 = {}

function grassclass:init(event)
	grass1 = Bitmap.new(Texture.new("background/grass" .. tostring(math.random(4)) .. ".png"))	
	grass1:setY(155)
	grass1:setX(320)
	stage:addChild(grass1)
	self:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
end

function grassclass:onEnterFrame(event)	
	local grassspeed = 120
	local x = grass1:getX() - grassspeed * event.deltaTime
	grass1:setX(x)
	if grass1:getX() < 0-grass1:getWidth() then
		grass1:setX(320)
	end
end
	
--[grass end]--