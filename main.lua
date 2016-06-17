local DirtClass = require("src/background/DirtClass")

local MagicianFClass = require("src/char/magician/female/MagicianFClass")
local MagicianFBubbleClass = require("src/char/magician/female/MagicianFBubbleClass")
local MagicianFBookClass = require("src/char/magician/female/MagicianFBookClass")

local SlimeClass = require("src/enemy/SlimeClass")

local Misc = require("src/helper/MiscClass")

local BattleEngineClass = require("src/core/BattleEngineClass")

local background = Bitmap.new(Texture.new("graphics/background/bg_grass.png"))
stage:addChild(background)

DirtClass.createDirt()

stage:setOrientation(Stage.PORTRAIT)

local magician = MagicianFClass.new()
magician:setY(320 - magician:getHeight())
magician:updateHUD()
stage:addChild(magician)

--[[
local magicianBook = MagicianFBookClass.new()
magicianBook:setX(magician:getX() + magician:getWidth() - 10)
magicianBook:setY(magician:getY() + magician:getHeight() / 2)
stage:addChild(magicianBook)

local magicianBubble = MagicianFBubbleClass.new()
magicianBubble:setX(magician:getX())
magicianBubble:setY(magician:getY())
stage:addChild(magicianBubble)]]

local slime = SlimeClass.new()
slime:setX(360 - (slime:getWidth() * 2))
slime:setY(320 - slime:getHeight())
slime:updateHUD()
stage:addChild(slime)

local sakuOrb = PuzzleClass.new()
stage:addChild(sakuOrb)

BattleEngineClass.init(magician, slime)

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
	Misc.bringToFront(magician)	
	--Misc.bringToFront(magicianBook)
	--Misc.bringToFront(magicianBubble)
	Misc.bringToFront(slime)
	Misc.bringToFront(magician.textHp)
	Misc.bringToFront(slime.textHp)
end

stage:addEventListener(Event.ENTER_FRAME, update)
