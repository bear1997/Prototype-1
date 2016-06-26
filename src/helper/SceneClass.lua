local CONST = require "src/helper/constants"

local SceneClass = {}

SHeroes = {}

function SceneClass.hideChooseChars()
	for i = 1, #SHeroes do
		if SHeroes[i] ~= nil then
			--SHeroes[i]:setAlpha(0)
			GTween.new(SHeroes[i], 0.5, {alpha = 0}, { ease = easing.inBack })
		end
	end
end

function SceneClass.chooseChars()
	--local faceMatrix = Matrix.new(1, 0, 0, 1, 0, 0)
	--SHeroes = {}
	
	--faceMatrix:setPosition(180, 128)
	SHeroes[1] = Shape.new()
	--SHeroes[1]:setFillStyle(Shape.TEXTURE, Texture.new("graphics/char/knight/male/face/knight_male_face_normal_300.png"), faceMatrix)
	SHeroes[1]:setFillStyle(Shape.SOLID, CONST.COLOR_RED, 0.5)	
	SHeroes[1]:beginPath()
	SHeroes[1]:moveTo(0, 0)
	SHeroes[1]:lineTo(360, 0)
	SHeroes[1]:lineTo(360, 64)
	SHeroes[1]:lineTo(0, 192)
	SHeroes[1]:lineTo(0, 0)
	SHeroes[1]:endPath()
	SHeroes[1]:setPosition(0, 0)
	
	SHeroes[2] = Shape.new()
	--SHeroes[2]:setFillStyle(Shape.TEXTURE, Texture.new("graphics/char/archer/female/face/archer_female_face_normal_300.png"), faceMatrix)
	SHeroes[2]:setFillStyle(Shape.SOLID, CONST.COLOR_GREEN, 0.5)
	SHeroes[2]:beginPath()
	SHeroes[2]:moveTo(0, 192)
	SHeroes[2]:lineTo(360, 64)
	SHeroes[2]:lineTo(360, 256)	
	SHeroes[2]:lineTo(0, 380)
	SHeroes[2]:lineTo(0, 192)
	SHeroes[2]:endPath()
	SHeroes[2]:setPosition(0, 0)
	
	SHeroes[3] = Shape.new()
	--SHeroes[3]:setFillStyle(Shape.TEXTURE, Texture.new("graphics/char/caster/female/face/caster_female_face_normal_300.png"), faceMatrix)
	SHeroes[3]:setFillStyle(Shape.SOLID, CONST.COLOR_YELLOW, 0.5)
	SHeroes[3]:beginPath()
	SHeroes[3]:moveTo(0, 380)
	SHeroes[3]:lineTo(360, 256)
	SHeroes[3]:lineTo(360, 444)
	SHeroes[3]:lineTo(0, 576)
	SHeroes[3]:lineTo(0, 380)
	SHeroes[3]:endPath()
	SHeroes[3]:setPosition(0, 0)
	
	SHeroes[4] = Shape.new()
	SHeroes[4]:setFillStyle(Shape.SOLID, CONST.COLOR_BLUE, 0.5)
	SHeroes[4]:beginPath()
	SHeroes[4]:moveTo(0, 576)
	SHeroes[4]:lineTo(360, 444)
	SHeroes[4]:lineTo(360, 640)	
	SHeroes[4]:lineTo(0, 640)
	SHeroes[4]:lineTo(0, 576)
	SHeroes[4]:endPath()
	SHeroes[4]:setPosition(0, 0)
end

function SceneClass.showDialogChar()
	GTween.new(Box1, 0.5, {alpha = 1}, { ease = easing.inBack })
	GTween.new(Box2, 0.5, {alpha = 1}, { ease = easing.inBack })
	GTween.new(Text1, 0.5, {alpha = 1}, { ease = easing.inBack })
	GTween.new(Text1, 0.5, {alpha = 1}, { ease = easing.inBack })
	GTween.new(Face1, 0.5, {alpha = 1}, { ease = easing.inBack })
	GTween.new(Face2, 0.5, {alpha = 1}, { ease = easing.inBack })
end

function SceneClass.hideDialogChar()
	GTween.new(Box1, 0.5, {alpha = 0}, { ease = easing.inBack })
	GTween.new(Box2, 0.5, {alpha = 0}, { ease = easing.inBack })
	GTween.new(Text1, 0.5, {alpha = 0}, { ease = easing.inBack })
	GTween.new(Text1, 0.5, {alpha = 0}, { ease = easing.inBack })
	GTween.new(Face1, 0.5, {alpha = 0}, { ease = easing.inBack })
	GTween.new(Face2, 0.5, {alpha = 0}, { ease = easing.inBack })
end

function SceneClass.showDialogBg()
	GTween.new(BgFade, 0.5, {alpha = 1}, { ease = easing.inBack })
	for i = 1, #TextList do
		if TextList[i] ~= nil then
			GTween.new(TextList[i], 0.5, {alpha = 1}, { ease = easing.inBack })
		end
	end
end

function SceneClass.hideDialogBg()
	GTween.new(BgFade, 0.5, {alpha = 0}, { ease = easing.inBack })
	for i = 1, #TextList do
		if TextList[i] ~= nil then
			GTween.new(TextList[i], 0.5, {alpha = 0}, { ease = easing.inBack })
		end
	end
end

return SceneClass