--[magician female start]--
magicianClass = Core.class(Sprite)

------------------------------------------------------------------------------------------------------------------
local pack = TexturePack.new("magician/female/walkingfemalemagi.txt","magician/female/walkingfemalemagi.png")
function magicianClass:init()
	self.anim = {
		Bitmap.new(pack:getTextureRegion("anim1.png")),
		Bitmap.new(pack:getTextureRegion("anim2.png")),
		Bitmap.new(pack:getTextureRegion("anim3.png")),
		Bitmap.new(pack:getTextureRegion("anim4.png")),
		Bitmap.new(pack:getTextureRegion("anim5.png")),
		Bitmap.new(pack:getTextureRegion("anim6.png")),
		Bitmap.new(pack:getTextureRegion("anim7.png")),
		Bitmap.new(pack:getTextureRegion("anim8.png")),
		Bitmap.new(pack:getTextureRegion("anim9.png")),
		Bitmap.new(pack:getTextureRegion("anim10.png")),
		Bitmap.new(pack:getTextureRegion("anim11.png")),
		Bitmap.new(pack:getTextureRegion("anim12.png"))
	}	
	self.frame = 1
	self:addChild(self.anim[1])
	self.nframes = #self.anim
	self.subframe = 0
	self:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
end
----------------------------------------------------------------------------------------------------------------------
function magicianClass:onEnterFrame()
	self.subframe = self.subframe + 1
	
	if self.subframe > 2 then
		self:removeChild(self.anim[self.frame])
		
		self.frame = self.frame + 1
		if self.frame > self.nframes then
			self.frame = 1
		end
		
		self:addChild(self.anim[self.frame])
		self:setY(120)
		self.subframe = 0
	end
end
--[magician female end]--