local BattleEngineClass = {}

--BattleEngineClass.player, BattleEngineClass.enemy = nil, nil
--local player, enemy = nil, nil

local dmg, miss, digit = 0, 0, 0
local player, enemy = nil, nil

function BattleEngineClass.init(obj1, obj2)
	player = obj1
	enemy = obj2
end

function BattleEngineClass.attackPlayer(obj)
	dmg = obj.stats.atk - player.stats.def
	if dmg < 0 then dmg = 0 end
	
	miss = obj.stats.spd - player.stats.spd
	if miss < 0 then miss = 0 end
	
	digit = #tostring(dmg)
	if digit > 1 then
		dmg = dmg + math.random(-2 * (digit - 1), 2 * (digit + 1))
	else
		dmg = dmg + math.random(-2 * digit, 2 * digit)
	end
	
	if math.floor(math.random(100)) < obj.stats.luck then dmg = dmg * math.random(1, 2) end
	
	if math.floor(math.random(100)) < miss then	dmg = 0	end
	
	player.stats.hp = player.stats.hp - dmg
	player.textHp:setText(player.stats.hp)
end

function BattleEngineClass.attackEnemy(obj)
	dmg = obj.stats.atk - enemy.stats.def
	if dmg < 0 then dmg = 0 end
	
	miss = obj.stats.spd - enemy.stats.spd
	if miss < 0 then miss = 0 end
	
	digit = #tostring(dmg)
	if digit > 1 then
		dmg = dmg + math.random(-2 * (digit - 1), 2 * (digit + 1))
	else
		dmg = dmg + math.random(-2 * digit, 2 * digit)
	end
	
	if math.floor(math.random(100)) < obj.stats.luck then dmg = dmg * math.random(1, 2) end
	
	if math.floor(math.random(100)) < miss then	dmg = 0	end

	enemy.stats.hp = enemy.stats.hp - dmg
	enemy.textHp:setText(enemy.stats.hp)
end

return BattleEngineClass
