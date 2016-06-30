-- Base class to derive for player and other ally characters

local LevelClass = require "src/core/LevelClass"

local BattleEngineClass = require "src/core/BattleEngineClass"

BasePlayerClass = Core.class(Sprite)

function BasePlayerClass:init(pack, len, stats)
	self.anim = {}
	for i = 1, len, 1 do
		self.anim[i] = Bitmap.new(pack:getTextureRegion("frame" .. i .. ".png"))
	end
	
	self.frame = 1
	self:addChild(self.anim[1])
	self.nframes = #self.anim
	self.subframe = 0
	self:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
	
	self.stats = {}
	LevelClass.setStats(self.stats, stats)
	
	self.textHp = TextField.new(nil, self.stats.hp)
	self.textHp:setTextColor(0xff0000)
	self.textHp:setScale(3)
	stage:addChild(self.textHp)
	
	--self:setVisible(false)
	--self.textHp:setVisible(false)
	
	return self
end

local skipFrame = 5

function BasePlayerClass:onEnterFrame()
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

function BasePlayerClass:updateHUD()
	self.textHp:setX(self:getX() + self:getWidth() / 2 - self.textHp:getWidth() / 2)	
	self.textHp:setY(self:getY() - self.textHp:getHeight())
end

function BasePlayerClass:attack()
	BattleEngineClass.attackEnemy(self)
end
