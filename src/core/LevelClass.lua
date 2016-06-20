local LevelClass = {}

function LevelClass.setStats(to, from)
	to.hp = from.hp
	to.atk = from.atk
	to.def = from.def
	to.mAtk = from.mAtk
	to.mDef = from.mDef
	to.spd = from.spd
	to.luck = from.luck
end

return LevelClass