local BattleEngineClass = {}

local player, enemy = nil, nil

function BattleEngineClass.init(obj1, obj2)
	player = obj1
	enemy = obj2
end

function BattleEngineClass.damagePlayer(dmg, obj)
	player.hp = player.hp - dmg
	player.textHp:setText(player.hp)
end

function BattleEngineClass.damageEnemy(dmg, obj)
	enemy.hp = enemy.hp - dmg
	enemy.textHp:setText(enemy.hp)
end

return BattleEngineClass
