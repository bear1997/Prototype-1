local CONST = require "src/helper/constants"

local SceneClass = {}

SHeroes = {}

function SceneClass.chooseChars()
	local faceMatrix = Matrix.new(1, 0, 0, 1, 0, -100)
	SHeroes = {}
	
	--faceMatrix:setPosition(180, 128)
	SHeroes[1] = Shape.new()
	--SHeroes[1]:setFillStyle(Shape.SOLID, CONST.COLOR_RED, 1)
	SHeroes[1]:setFillStyle(Shape.TEXTURE, Texture.new("graphics/char/magician/female/face/magigirl_face_normal_300.png"), faceMatrix)
	SHeroes[1]:beginPath()
	SHeroes[1]:moveTo(0, 0)
	SHeroes[1]:lineTo(360, 0)
	SHeroes[1]:lineTo(360, 64)	
	SHeroes[1]:lineTo(0, 192)
	SHeroes[1]:lineTo(0, 0)
	SHeroes[1]:endPath()
	SHeroes[1]:setPosition(0, 0)
	
	SHeroes[2] = Shape.new()
	SHeroes[2]:setFillStyle(Shape.SOLID, CONST.COLOR_GREEN, 1)
	SHeroes[2]:beginPath()
	SHeroes[2]:moveTo(0, 192)
	SHeroes[2]:lineTo(360, 64)
	SHeroes[2]:lineTo(360, 256)	
	SHeroes[2]:lineTo(0, 380)
	SHeroes[2]:lineTo(0, 192)
	SHeroes[2]:endPath()
	SHeroes[2]:setPosition(0, 0)
	
	SHeroes[3] = Shape.new()
	SHeroes[3]:setFillStyle(Shape.SOLID, CONST.COLOR_BLUE, 1)
	SHeroes[3]:beginPath()
	SHeroes[3]:moveTo(0, 380)
	SHeroes[3]:lineTo(360, 256)
	SHeroes[3]:lineTo(360, 444)	
	SHeroes[3]:lineTo(0, 576)
	SHeroes[3]:lineTo(0, 380)
	SHeroes[3]:endPath()
	SHeroes[3]:setPosition(0, 0)
	
	SHeroes[4] = Shape.new()
	SHeroes[4]:setFillStyle(Shape.SOLID, CONST.COLOR_YELLOW, 1)
	SHeroes[4]:beginPath()
	SHeroes[4]:moveTo(0, 576)
	SHeroes[4]:lineTo(360, 444)
	SHeroes[4]:lineTo(360, 640)	
	SHeroes[4]:lineTo(0, 640)
	SHeroes[4]:lineTo(0, 576)
	SHeroes[4]:endPath()
	SHeroes[4]:setPosition(0, 0)
end

return SceneClass