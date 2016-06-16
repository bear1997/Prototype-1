MagicianFClass = Core.class(Sprite)

local pack = TexturePack.new("graphics/magician/female/walking/walking.txt","graphics/magician/female/walking/walking.png")
function MagicianFClass:init()
	self.anim = {
		Bitmap.new(pack:getTextureRegion("frame1.png")),
		Bitmap.new(pack:getTextureRegion("frame2.png")),
		Bitmap.new(pack:getTextureRegion("frame3.png"))
	}
	self.frame = 1
	self:addChild(self.anim[1])
	self.nframes = #self.anim
	self.subframe = 0
	self:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
	
	return self
end

local skipFrame = 5

function MagicianFClass:onEnterFrame()
	if skipFrame == 0 then
		self.subframe = self.subframe + 1
		
		if self.subframe > 2 then
			self:removeChild(self.anim[self.frame])
		
			self.frame = self.frame + 1
			if self.frame > self.nframes then
				self.frame = 1
			end
		
			self:addChild(self.anim[self.frame])			
			self.subframe = 0
		end
		
		skipFrame = 5
	end
	skipFrame = skipFrame - 1
end