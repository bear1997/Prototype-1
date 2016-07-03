-- Calculate the battle damage

local ENEMY = require "src/res/enemies"

local LevelClass = require "src/core/LevelClass"
--local ScriptClass = require "src/helper/ScriptClass"

local BattleEngineClass = {}
local self = BattleEngineClass

--BattleEngineClass.player, BattleEngineClass.enemy = nil, nil
Player, Enemy = nil, nil
--local player, enemy = nil, nil

IsWon = nil

local dmg, miss, digit = 0, 0, 0
--local player, enemy = nil, nil

function BattleEngineClass.new()
	return self
end

function BattleEngineClass:setup(obj1, obj2)
	Player = obj1
	Enemy = obj2
	
	Level:saveStats(Player.stats)	
	
	self:stopBattle()
end

function BattleEngineClass:attackPlayer(obj)
	--dmg = obj.stats.atk - BattleEngineClass.player.stats.def
	dmg = obj.stats.atk - Player.stats.def
	if dmg < 0 then dmg = 0 end
	
	--miss = obj.stats.spd - BattleEngineClass.player.stats.spd
	miss = obj.stats.spd - Player.stats.spd
	if miss < 0 then miss = 0 end
	
	digit = #tostring(dmg)
	if digit > 1 then
		dmg = dmg + math.random(-2 * (digit - 1), 2 * (digit + 1))
	else
		dmg = dmg + math.random(-2 * digit, 2 * digit)
	end
	
	if math.floor(math.random(100)) < obj.stats.luck then dmg = dmg * math.random(1, 2) end
	
	if math.floor(math.random(100)) < miss then	dmg = 0	end
	
	--BattleEngineClass.player.stats.hp = BattleEngineClass.player.stats.hp - dmg
	--BattleEngineClass.player.textHp:setText(BattleEngineClass.player.stats.hp)
	Player.stats.hp = Player.stats.hp - dmg
	
	Player.stats.hp = Player.stats.hp - dmg
	
	if Player.stats.hp < 0 then
		Player.stats.hp = 0
		IsWon = false
	end
	
	Player.textHp:setText(Player.stats.hp)
	
	if Player.stats.hp <= 0 then	
		self:stopBattle()
		self:sendResult()
		--ScriptClass.continueScript()
	end
end

function BattleEngineClass:attackEnemy(obj, orbNum)
	--dmg = obj.stats.atk - BattleEngineClass.enemy.stats.def
	dmg = obj.stats.atk - Enemy.stats.def
	if dmg < 0 then dmg = 0 end
	
	--miss = obj.stats.spd - BattleEngineClass.enemy.stats.spd
	miss = obj.stats.spd - Enemy.stats.spd
	if miss < 0 then miss = 0 end
	
	digit = #tostring(dmg)
	if digit > 1 then
		dmg = dmg + math.random(-2 * (digit - 1), 2 * (digit + 1)) + orbNum * math.random(1 * (digit - 1), 5 * (digit + 1))
	else
		dmg = dmg + math.random(-2 * digit, 2 * digit) + orbNum * math.random(1 * digit, 5 * digit)
	end
	
	if math.floor(math.random(100)) < obj.stats.luck then dmg = dmg * math.random(1, 2) end
	
	if math.floor(math.random(100)) < miss then	dmg = 0	end

	--BattleEngineClass.enemy.stats.hp = BattleEngineClass.enemy.stats.hp - dmg
	--BattleEngineClass.enemy.textHp:setText(BattleEngineClass.enemy.stats.hp)
	Enemy.stats.hp = Enemy.stats.hp - dmg
	
	if Enemy.stats.hp < 0 then
		Enemy.stats.hp = 0
		IsWon = true
	end
	
	Enemy.textHp:setText(Enemy.stats.hp)
	
	if Enemy.stats.hp <= 0 then		
		self:stopBattle()
		self:sendResult()
		--ScriptClass.continueScript()
	end
end

function BattleEngineClass:stopBattle()
	print("stop battle")
	Enemy:stopAttack()
end

function BattleEngineClass:startBattle()
	print("start battle")
	--LevelClass.saveStats(Player.stats)	
	
	Player.textHp:setText(Player.stats.hp)
	Enemy.textHp:setText(Enemy.stats.hp)
	
	Enemy:startAttack()
end

function BattleEngineClass:resetStats()
	print("reset stats")
	Level:setStats(Enemy.stats, ENEMY.SLIME)
	Level:loadStats(Player.stats)
	
	Player.textHp:setText(Player.stats.hp)
	Enemy.textHp:setText(Enemy.stats.hp)
end

function BattleEngineClass:sendResult()
	local resultEvent = Event.new("BATTLE_RESULT")
	stage:dispatchEvent(resultEvent)
end

return BattleEngineClass
