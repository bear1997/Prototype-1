local MagicianFClass = {}

local pack = TexturePack.new("graphics/char/magician/female/walking/walking.txt", "graphics/char/magician/female/walking/walking.png")

function MagicianFClass.new()
	local stats = {}
	stats.hp = 20

	return BasePlayerClass.new(pack, 3, stats)
end

return MagicianFClass
