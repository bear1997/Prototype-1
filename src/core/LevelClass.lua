-- Manage the level stuff, such as stats, attribut, etc

local LevelClass = {}
local self = LevelClass

local oriHp, oriAtk, oriDef, oriMAtk, oriMDef, oriSpd, oriLuck = 0, 0, 0, 0, 0, 0, 0

function LevelClass.new()
	return self
end

function LevelClass:setStats(to, from)
	to.hp = from.hp
	to.atk = from.atk
	to.def = from.def
	to.mAtk = from.mAtk
	to.mDef = from.mDef
	to.spd = from.spd
	to.luck = from.luck
end

function LevelClass:saveStats(obj)
	oriHp = obj.hp
	oriAtk = obj.atk
	oriDef = obj.def
	oriMAtk = obj.mAtk
	oriMDef = obj.mDef
	oriSpd = obj.spd
	oriLuck = obj.luck
end

function LevelClass:loadStats(obj)
	if oriHp ~= 0 then
		obj.hp = oriHp
		obj.atk = oriAtk
		obj.def = oriDef
		obj.mAtk = oriMAtk
		obj.mDef = oriMDef
		obj.spd = oriSpd
		obj.luck = oriLuck
	end
end

return LevelClass