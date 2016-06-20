local BattleEngineClass = {}

BattleEngineClass.player, BattleEngineClass.enemy = nil, nil
--local player, enemy = nil, nil

local dmg, miss, digit = 0, 0, 0
--local player, enemy = nil, nil

function BattleEngineClass.init(obj1, obj2)
	BattleEngineClass.player = obj1
	BattleEngineClass.enemy = obj2
end

function BattleEngineClass.attackPlayer(obj)
	dmg = obj.stats.atk - BattleEngineClass.player.stats.def
	if dmg < 0 then dmg = 0 end
	
	miss = obj.stats.spd - BattleEngineClass.player.stats.spd
	if miss < 0 then miss = 0 end
	
	digit = #tostring(dmg)
	if digit > 1 then
		dmg = dmg + math.random(-2 * (digit - 1), 2 * (digit + 1))
	else
		dmg = dmg + math.random(-2 * digit, 2 * digit)
	end
	
	if math.floor(math.random(100)) < obj.stats.luck then dmg = dmg * math.random(1, 2) end
	
	if math.floor(math.random(100)) < miss then	dmg = 0	end
	
	BattleEngineClass.player.stats.hp = BattleEngineClass.player.stats.hp - dmg
	BattleEngineClass.player.textHp:setText(BattleEngineClass.player.stats.hp)
end

function BattleEngineClass.attackEnemy(obj, orbNum)
	dmg = obj.stats.atk - BattleEngineClass.enemy.stats.def
	if dmg < 0 then dmg = 0 end
	
	miss = obj.stats.spd - BattleEngineClass.enemy.stats.spd
	if miss < 0 then miss = 0 end
	
	digit = #tostring(dmg)
	if digit > 1 then
		dmg = dmg + math.random(-2 * (digit - 1), 2 * (digit + 1)) + orbNum * math.random(1 * (digit - 1), 5 * (digit + 1))
	else
		dmg = dmg + math.random(-2 * digit, 2 * digit) + orbNum * math.random(1 * digit, 5 * digit)
	end
	
	if math.floor(math.random(100)) < obj.stats.luck then dmg = dmg * math.random(1, 2) end
	
	if math.floor(math.random(100)) < miss then	dmg = 0	end

	BattleEngineClass.enemy.stats.hp = BattleEngineClass.enemy.stats.hp - dmg
	BattleEngineClass.enemy.textHp:setText(BattleEngineClass.enemy.stats.hp)
end

return BattleEngineClass
