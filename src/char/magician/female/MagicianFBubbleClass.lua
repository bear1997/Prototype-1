local MagicianFBubbleClass = {}

local pack = TexturePack.new("graphics/char/magician/female/bubble/bubble.txt", "graphics/char/magician/female/bubble/bubble.png")

function MagicianFBubbleClass.new()
	return BasePlayerClass.new(pack, 5)
end

return MagicianFBubbleClass
