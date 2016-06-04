--[cloud start]--
cloudClass = Core.class(Sprite)

function cloudClass:init()	
	self.cloud = Bitmap.new(Texture.new("background/cloud" .. tostring(math.random(3)) .. ".png"))	
	self.cloud:setY(10)
	self.cloud:setX(320)
	stage:addChild(self.cloud)
	return self
end

function cloudClass:update(dt)	
	local cloudSpeed = 30
	local x = self.cloud:getX() - cloudSpeed * dt
	self.cloud:setX(x)
end

--[cloud end]--