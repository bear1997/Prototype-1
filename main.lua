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

local grass_list, cloud_list = {}, {}
local grassTimer = Timer.new(math.random(1, 2) * 1000, 0)
local cloudTimer = Timer.new(math.random(2, 3) * 1000, 0)

function update(event)
	local grass_len, cloud_len, i = #grass_list, #cloud_list, 1
	
	while grass_len > 0 and cloud_len > 0 do
		if grass_list[i] ~= nil then
			grass_list[i]:update(event.deltaTime)
			grass_len = grass_len - 1			
			
			if Misc.isOverbound(grass_list[i].grass) then
				stage:removeChild(grass_list[i].grass)
				table.remove(grass_list, i)
			end
		end
		
		if cloud_list[i] ~= nil then
			cloud_list[i]:update(event.deltaTime)
			cloud_len = cloud_len - 1
			
			if Misc.isOverbound(cloud_list[i].cloud) then
				stage:removeChild(cloud_list[i].cloud)
				table.remove(cloud_list, i)
			end
		end
		i = i + 1
	end
end

function spawnGrass(event)
	local i = 1	
	
	while true do
		if grass_list[i] == nil then
			grass_list[i] = grassClass.new()
			
			grassTimer:setDelay(math.random(1, 3) * 1000)
			break
		end
		i = i + 1
	end
end

function spawnCloud(event)
	local cloud, i = cloudClass.new(), 1
	
	while true do
		if cloud_list[i] == nil then
			cloud_list[i] = cloudClass.new()
			
			cloudTimer:setDelay(math.random(1, 3) * 1000)
			break
		end
		i = i + 1
	end
end

grassTimer:addEventListener(Event.TIMER, spawnGrass)
grassTimer:start()

cloudTimer:addEventListener(Event.TIMER, spawnCloud)
cloudTimer:start()

stage:addEventListener(Event.ENTER_FRAME, update, self)

-- Experimental functions end
