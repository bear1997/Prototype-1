-- Mainly for manage scene state switching, and animation optionally

local CONST = require "src/res/constants"

local BattleEngineClass = require "src/core/BattleEngineClass"

local SceneClass = {}
local self = SceneClass

SHeroes = {}

function SceneClass.new()
	return self
end

function SceneClass:restartBattleMode()
	self:hideBattleMode()
end

function SceneClass:showBattleMode()
	if isBattleInit == false then
		IsBattleInit = true
					
		BattleEngine:setup(Magician, Slime)
	end
	
	BattleEngine:startBattle()
	print("show "..Player.stats.hp)
	--Player:setVisible(true)
	--Player.textHp:setVisible(true)
	--Enemy:setVisible(true)
	--Enemy.textHp:setVisible(true)
	
	SakuOrb:showAllOrbs()
	Player:setAlpha(1)
	Player.textHp:setAlpha(1)
	Enemy:setAlpha(1)
	Enemy.textHp:setAlpha(1)
	--[[
	GTween.new(Player, 0.5, {alpha = 100}, { ease = easing.inBack })
	GTween.new(Player.textHp, 0.5, {alpha = 100}, { ease = easing.inBack })
	GTween.new(Enemy, 0.5, {alpha = 100}, { ease = easing.inBack })
	GTween.new(Enemy.textHp, 0.5, {alpha = 100}, { ease = easing.inBack })]]
end

function SceneClass.hideBattleMode()
	SakuOrb:hideAllOrbs()
	Player:setAlpha(0)
	Player.textHp:setAlpha(0)
	Enemy:setAlpha(0)
	Enemy.textHp:setAlpha(0)
	--[[
	GTween.new(Player, 0.5, {alpha = 0}, { ease = easing.inBack })
	GTween.new(Player.textHp, 0.5, {alpha = 0}, { ease = easing.inBack })
	GTween.new(Enemy, 0.5, {alpha = 0}, { ease = easing.inBack })
	GTween.new(Enemy.textHp, 0.5, {alpha = 0}, { ease = easing.inBack })]]
	BattleEngine:resetStats()
	print("hide "..Player.stats.hp)
end

function SceneClass:hideChooseChars()
	--print("hideChooseChars")
	for i = 1, #SHeroes do
		if SHeroes[i] ~= nil then
			--SHeroes[i]:setAlpha(0)
			GTween.new(SHeroes[i], 0.5, {alpha = 0}, { ease = easing.inBack })
		end
	end
end

function SceneClass:chooseChars()
	--print("chooseChars")
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

function SceneClass:show(sprite, len)
	--print("show")
	sprite:setVisible(true)
	if len == nil then len = 0.5 end
	
	GTween.new(sprite, len, {alpha = 1}, { ease = easing.inBack })
end

function SceneClass:hide(sprite, len)
	--print("hide")
	if len == nil then len = 0.5 end
	
	GTween.new(sprite, len, {alpha = 0}, { ease = easing.inBack })
end

function SceneClass:showDialogChar()
	--print("showDialogChar")
	GTween.new(Box1, 0.5, {alpha = 1}, { ease = easing.inBack })
	GTween.new(Box2, 0.5, {alpha = 1}, { ease = easing.inBack })
	GTween.new(Text1, 0.5, {alpha = 1}, { ease = easing.inBack })
	GTween.new(Text1, 0.5, {alpha = 1}, { ease = easing.inBack })
	GTween.new(Face1, 0.5, {alpha = 1}, { ease = easing.inBack })
	GTween.new(Face2, 0.5, {alpha = 1}, { ease = easing.inBack })
	GTween.new(Name1, 0.5, {alpha = 1}, { ease = easing.inBack })
	GTween.new(Name2, 0.5, {alpha = 1}, { ease = easing.inBack })
end

function SceneClass:hideDialogChar()
	--print("hideDialogChar")
	GTween.new(Box1, 0.5, {alpha = 0}, { ease = easing.inBack })
	GTween.new(Box2, 0.5, {alpha = 0}, { ease = easing.inBack })
	GTween.new(Text1, 0.5, {alpha = 0}, { ease = easing.inBack })
	GTween.new(Text1, 0.5, {alpha = 0}, { ease = easing.inBack })
	GTween.new(Face1, 0.5, {alpha = 0}, { ease = easing.inBack })
	GTween.new(Face2, 0.5, {alpha = 0}, { ease = easing.inBack })
	GTween.new(Name1, 0.5, {alpha = 0}, { ease = easing.inBack })
	GTween.new(Name2, 0.5, {alpha = 0}, { ease = easing.inBack })
end

function SceneClass:showDialogBg()
	--print("showDialogBg")
	GTween.new(BgFade, 0.5, {alpha = 1}, { ease = easing.inBack })
	for i = 1, #TextList do
		if TextList[i] ~= nil then
			GTween.new(TextList[i], 0.5, {alpha = 1}, { ease = easing.inBack })
		end
	end
end

function SceneClass:hideDialogBg()
	--print("hideDialogBg")
	GTween.new(BgFade, 0.5, {alpha = 0}, { ease = easing.inBack })
	for i = 1, #TextList do
		if TextList[i] ~= nil then
			GTween.new(TextList[i], 0.5, {alpha = 0}, { ease = easing.inBack })
		end
	end
end

return SceneClass