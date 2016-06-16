local SlimeClass = {}

local pack = TexturePack.new("graphics/char/magician/female/walking/walking.txt", "graphics/char/magician/female/walking/walking.png")

function SlimeClass.new()
	return BaseAnimClass.new(pack, 3)
end

return SlimeClass
