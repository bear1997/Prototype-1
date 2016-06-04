--[puzzle start]--
sakuClass = Core.class(Sprite)

local saku = {}
local OrbId = {}

function sakuClass:init(event)
	local initialX = 230
	local initialY = 140
	
	for row = 1,4 do
		saku[row] = {}
		OrbId[row] = {}
		for col = 1,20 do
			local index = math.random(4)
			saku[row][col] = Bitmap.new(Texture.new("SakuOrb/"..tostring(index)..".png"))
			stage:addChild(saku[row][col])
			saku[row][col]:setX(initialX + col * 70)
			saku[row][col]:setY(initialY + row * 70)
			
			if index == 1 then
				OrbId[row][col] = 1
			elseif index == 2 then
				OrbId[row][col] = 2
			elseif index == 3 then
				OrbId[row][col] = 3
			else
				OrbId[row][col] = 4
			end
		end
	end
	
	self:addEventListener(Event.MOUSE_UP, sakuClass.onTouches, self)
end

function sakuClass:onTouches()
	stage:addEventListener(Event.ENTER_FRAME, sakuClass.onEnterFrame, self)
	--[[if saku[4][20]:getX() < 0 - saku[4][20]:getWidth() then
		stage:removeEventListener(Event.REMOVE_FROM_STAGE, sakuClass.onEnterFrame, self)
	end]]--
end

function sakuClass:onEnterFrame(event)
	local orbspeed = 300
	for row = 1,4 do
		for col = 1,20 do
			local x = saku[row][col]:getX() - orbspeed * event.deltaTime
			saku[row][col]:setX(x)
		end
		print(saku[1][1]:getX())
		print(saku[4][20]:getX())
	end
end
