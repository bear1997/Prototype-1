-- Class for magician female

local MagicianFClass = {}

local pack = TexturePack.new("graphics/char/caster/female/walking/walking.txt", "graphics/char/caster/female/walking/walking.png")

function MagicianFClass.new()
	local stats = { 
		hp = 20,
		atk = 10,
		def = 5,
		mAtk = 14,
		mDef = 12,
		spd = 8,
		luck = 10
	}
	--[[
	stats.hp = 20
	stats.attack = 10
	stats.]]

	return BasePlayerClass.new(pack, 3, stats)
end

return MagicianFClass
