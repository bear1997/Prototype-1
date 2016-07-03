-- The entry point of game where this is the origin of everything

local DirtClass = require "src/background/DirtClass"

local MagicianFClass = require "src/char/magician/female/MagicianFClass"
local MagicianFBubbleClass = require "src/char/magician/female/MagicianFBubbleClass"
local MagicianFBookClass = require "src/char/magician/female/MagicianFBookClass"

local SlimeClass = require "src/enemy/SlimeClass"

local CONST = require "src/res/constants"
local TEX = require "src/res/textures"
local MiscClass = require "src/helper/MiscClass"
local ScriptClass = require "src/helper/ScriptClass"
local SceneClass = require "src/helper/SceneClass"
local LevelClass = require "src/core/LevelClass"

local BattleEngineClass = require("src/core/BattleEngineClass")

local background = Bitmap.new(TEX.BG_GRASS)
stage:addChild(background)

DirtClass.createDirt()

stage:setOrientation(Stage.PORTRAIT)

Level = LevelClass.new()
Scene = SceneClass.new()

Magician = MagicianFClass.new()
Magician:setY(320 - Magician:getHeight())
Magician:updateHUD()
stage:addChild(Magician)

--[[
local magicianBook = MagicianFBookClass.new()
magicianBook:setX(magician:getX() + magician:getWidth() - 10)
magicianBook:setY(magician:getY() + magician:getHeight() / 2)
stage:addChild(magicianBook)

local magicianBubble = MagicianFBubbleClass.new()
magicianBubble:setX(magician:getX())
magicianBubble:setY(magician:getY())
stage:addChild(magicianBubble)]]

Slime = SlimeClass.new()
Slime:setX(360 - (Slime:getWidth() * 2))
Slime:setY(320 - Slime:getHeight())
Slime:updateHUD()
stage:addChild(Slime)

SakuOrb = PuzzleClass.new()
stage:addChild(SakuOrb)

BattleEngine = BattleEngineClass.new()

--Level = LevelClass.new()

--Scene = SceneClass.new()

ScriptClass:setup()

-----------------------------------------------------------------------------------------------------------------

-- Grass and cloud spawn start

local grassTimer = Timer.new(math.random(1, 2) * 1000, 0)
local cloudTimer = Timer.new(math.random(2, 3) * 1000, 0)

function spawnGrass(event)
	stage:addChild(GrassClass.new())
	grassTimer:setDelay(math.random(3, 5) * 1000)
end

function spawnCloud(event)
	stage:addChild(CloudClass.new())
	cloudTimer:setDelay(math.random(5, 7) * 1000)
end

function cleanUp(event)
	if event.obj.isCleaned == false then
		event.obj.isCleaned = true
		stage:removeChild(event.obj)
	end
end

grassTimer:addEventListener(Event.TIMER, spawnGrass)
grassTimer:start()

cloudTimer:addEventListener(Event.TIMER, spawnCloud)
cloudTimer:start()

stage:addEventListener("REMOVE_CHILD", cleanUp)

-- Grass and cloud spawn end

function update(event)
	if CurrSceneState == CONST.SCENE_DIALOG_BG then
		MiscClass.bringToFront(BgFade)
	
		for i = 1, #TextList do
			if TextList[i] ~= nil then
				MiscClass.bringToFront(TextList[i])
			end
		end
	elseif CurrSceneState == CONST.SCENE_DIALOG_CHAR then	
		MiscClass.bringToFront(Box1)
		MiscClass.bringToFront(Box2)
		MiscClass.bringToFront(Face1)
		MiscClass.bringToFront(Face2)
		MiscClass.bringToFront(Text1)
		MiscClass.bringToFront(Text2)
		MiscClass.bringToFront(Name1)
		MiscClass.bringToFront(Name2)
	elseif CurrSceneState == CONST.SCENE_CHOOSE_CHARS then
		for i = 1, #SHeroes do
			if SHeroes[i] ~= nil then			
				MiscClass.bringToFront(SHeroes[i])
			end
		end
	elseif CurrSceneState == CONST.SCENE_BATTLE then
		MiscClass.bringToFront(Magician)	
		--MiscClass.bringToFront(magicianBook)
		--MiscClass.bringToFront(magicianBubble)
		MiscClass.bringToFront(Slime)
		MiscClass.bringToFront(Magician.textHp)
		MiscClass.bringToFront(Slime.textHp)
	end
end

stage:addEventListener(Event.ENTER_FRAME, update)
