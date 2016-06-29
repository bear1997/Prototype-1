-- Class for magician female bubble

local MagicianFBubbleClass = {}

local pack = TexturePack.new("graphics/char/caster/female/bubble/bubble.txt", "graphics/char/caster/female/bubble/bubble.png")

function MagicianFBubbleClass.new()
	return BasePlayerClass.new(pack, 5)
end

return MagicianFBubbleClass
