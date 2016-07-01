-- Enemy: Slime

local ENEMY = require "src/res/enemies"

local SlimeClass = {}

function SlimeClass.new()
	local stats = ENEMY.SLIME

	return BaseEnemyClass.new("graphics/enemy/slime.png", stats)
end

return SlimeClass
