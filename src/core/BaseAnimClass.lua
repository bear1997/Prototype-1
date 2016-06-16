BaseAnimClass = Core.class(Sprite)

function BaseAnimClass:init(pack, len)
	self.anim = {}
	for i = 1, len, 1 do
		self.anim[i] = Bitmap.new(pack:getTextureRegion("frame" .. i .. ".png"))
	end
	
	self.frame = 1
	self:addChild(self.anim[1])
	self.nframes = #self.anim
	self.subframe = 0
	self:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
	
	return self
end

local skipFrame = 5

function BaseAnimClass:onEnterFrame()
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
