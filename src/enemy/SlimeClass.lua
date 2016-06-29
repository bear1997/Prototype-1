-- Enemy: Slime

local SlimeClass = {}

function SlimeClass.new()
	local stats = { 
		hp = 10,
		atk = 10,
		def = 5,
		mAtk = 0,
		mDef = 0,
		spd = 1,
		luck = 1
	}

	return BaseEnemyClass.new("graphics/enemy/slime.png", stats)
end

return SlimeClass
