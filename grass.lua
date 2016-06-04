--[grass start]--
grassClass = Core.class(Sprite)

function grassClass:init(event)
	self.grass = Bitmap.new(Texture.new("background/grass" .. tostring(math.random(4)) .. ".png"))	
	self.grass:setY(155)
	self.grass:setX(320)
	stage:addChild(self.grass)
	return self
end

function grassClass:update(dt)	
	local grassSpeed = 120
	local x = self.grass:getX() - grassSpeed * dt
	self.grass:setX(x)
end
	
--[grass end]--