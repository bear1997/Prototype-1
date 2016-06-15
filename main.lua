local background = Bitmap.new(Texture.new("g_background/bg_grass.png"))
stage:addChild(background)

local dirt = require("DirtClass")
dirt.createDirt()

local Misc = require("helper/MiscClass")

stage:setOrientation(Stage.PORTRAIT)

local magician = MagicianFClass.new()
magician:setY(320 - magician:getHeight())
stage:addChild(magician)

--[[
local magicianBook = magicianFBookClass.new()
magicianBook:setX(magician:getX() + magician:getWidth() - 10)
magicianBook:setY(magician:getY() + magician:getHeight() / 2)
stage:addChild(magicianBook)]]
--[[
local magicianBubble = magicianFBubbleClass.new()
magicianBubble:setX(magician:getX())
magicianBubble:setY(magician:getY())
stage:addChild(magicianBubble)]]

local sakuorb = PuzzleClass.new()
stage:addChild(sakuorb)

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
end

stage:addEventListener(Event.ENTER_FRAME, update)
