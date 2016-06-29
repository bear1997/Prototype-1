-- Base class to derive for enemies

local LevelClass = require "src/core/LevelClass"

local BattleEngineClass = require "src/core/BattleEngineClass"

BaseEnemyClass = Core.class(Sprite)

function BaseEnemyClass:init(img, stats)
	self:addChild(Bitmap.new(Texture.new(img)))
	--[[
	self.anim = {}
	for i = 1, len, 1 do
		self.anim[i] = Bitmap.new(pack:getTextureRegion("frame" .. i .. ".png"))
	end
	
	self.frame = 1
	self:addChild(self.anim[1])
	self.nframes = #self.anim
	self.subframe = 0
	self:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)]]
	
	self.stats = {}
	LevelClass.setStats(self.stats, stats)
	
	self.textHp = TextField.new(nil, self.stats.hp)
	self.textHp:setTextColor(0xff0000)
	self.textHp:setScale(3)
	stage:addChild(self.textHp)
	
	self.attackTimer = Timer.new(math.random(2, 4) * 1000, 0)
	self.attackTimer:addEventListener(Event.TIMER, BaseEnemyClass.attack, self)
	self.attackTimer:start()
	
	self:setVisible(false)
	self.textHp:setVisible(false)
	
	return self
end
--[[
local skipFrame = 5

function BaseEnemy:onEnterFrame()
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
end]]

function BaseEnemyClass:updateHUD()
	self.textHp:setX(self:getX() + self:getWidth() / 2 - self.textHp:getWidth() / 2)
	self.textHp:setY(self:getY() - self.textHp:getHeight())
end

function BaseEnemyClass:attack()
	BattleEngineClass.attackPlayer(self)
end