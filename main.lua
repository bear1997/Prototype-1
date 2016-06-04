--[background start]--

local background = Bitmap.new(Texture.new("background/bg_grass.png"))
stage : addChild(background)
--[background end]--

local dirt = require("dirt")
dirt.dirt()

local Misc = require("helper/misc")

stage:setOrientation(Stage.PORTRAIT)

local magician = walkingClass.new()
stage:addChild(magician)

stage:setOrientation(Stage.PORTRAIT)
local sakuorb = sakuClass.new()
stage:addChild(sakuorb)

-----------------------------------------------------------------------------------------------------------------

-- Experimental functions start

local grassTimer = Timer.new(math.random(1, 2) * 1000, 0)
local cloudTimer = Timer.new(math.random(2, 3) * 1000, 0)

function spawnGrass(event)
	stage:addChild(grassClass.new())
	grassTimer:setDelay(math.random(3, 5) * 1000)
end

function spawnCloud(event)
	stage:addChild(cloudClass.new())
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

-- Experimental functions end
