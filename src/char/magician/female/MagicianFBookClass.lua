local MagicianFBookClass = {}

local pack = TexturePack.new("graphics/char/caster/female/book/book.txt", "graphics/char/caster/female/book/book.png")

function MagicianFBookClass.new()
	return BasePlayerClass.new(pack, 5)
end

return MagicianFBookClass
