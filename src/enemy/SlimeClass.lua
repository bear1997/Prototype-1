local SlimeClass = {}

function SlimeClass.new()
	local stats = {}
	stats.hp = 10

	return BaseEnemyClass.new("graphics/enemy/slime.png", stats)
end

return SlimeClass
