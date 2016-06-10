--[puzzle start]--
sakuClass = Core.class(Sprite)

local orbLayer = {}
local orbId = {}
local orbBoolean = {}

local last_row = 0
local last_col = 0

local blueOrb = 0
local greenOrb = 0
local yellowOrb = 0
local redOrb = 0

local colmax = 7
-------------------------------------------------------------------------------------------
function sakuClass:init(event)
	local initialX = 230
	local initialY = 320
	--[[
	for row = 1,4 do
		saku[row] = {}
		orbId[row] = {}
		for col = 1,20 do
			local index = math.random(4)
			saku[row][col] = Bitmap.new(Texture.new("SakuOrb/"..tostring(index)..".png"))
			stage:addChild(saku[row][col])
			saku[row][col]:setX(initialX + col * 70)
			saku[row][col]:setY(initialY + row * 70)
			
			if index == 1 then
				orbId[row][col] = 1
			elseif index == 2 then
				orbId[row][col] = 2
			elseif index == 3 then
				orbId[row][col] = 3
			else
				orbId[row][col] = 4
			end
		end
	end--]]

	for row = 1,5,1 do
		orbLayer[row] = {}
		orbId[row] = {}
		orbBoolean[row] = {}
		for col = 1,colmax,1 do
			local color = math.random(4)
			orbLayer[row][col] = Bitmap.new(Texture.new("g_saku_orb/"..tostring(color)..".png"))
			stage:addChild(orbLayer[row][col])
			--orbLayer[row][col]:setX(initialX + col * 70)
			--dirtLayer[i][j]:setX((j - 1) * dirtLayer[i][j]:getWidth() -50)
			orbLayer[row][col]:setX((col - 1) * orbLayer[row][col]:getWidth() - 44)
			orbLayer[row][col]:setY(initialY + (row - 1) * 64)			

			if color == 1 then
				orbId[row][col] = 1
			elseif color == 2 then
				orbId[row][col] = 2
			elseif color == 3 then
				orbId[row][col] = 3
			else
				orbId[row][col] = 4
			end
			orbBoolean[row][col] = false
		end
	end
	
	self:addEventListener(Event.MOUSE_UP, sakuClass.onTouches, self)
	self:addEventListener(Event.TOUCHES_MOVE, sakuClass.onHit, self)
	self:addEventListener(Event.TOUCHES_END, sakuClass.orbCount, self)
	blueOrb = 0
	greenOrb = 0
	yellowOrb = 0
	redOrb = 0
end
-----------------------------------------------------------------------------------------------------
function sakuClass:onTouches()
	--stage:addEventListener(Event.ENTER_FRAME, sakuClass.onEnterFrame, self)
	--[[if saku[4][20]:getX() < 0 - saku[4][20]:getWidth() then
		stage:removeEventListener(Event.REMOVE_FROM_STAGE, sakuClass.onEnterFrame, self)
	end]]--
end
--------------------------------------------------------------------------------------------------------
function sakuClass:onEnterFrame(event)
	local orbSpeed = 300
	for row = 1,5 do
		for col = 1,colmax do
			local x = orbLayer[row][col]:getX() - orbSpeed * event.deltaTime
			orbLayer[row][col]:setX(x)
		end
	end
end
-------------------------------------------------------------------------------------------------------------

function sakuClass:onHit(event)

	old_x, old_y = new_x, new_y
	new_x, new_y = event.touch.x, event.touch.y
	
	for row = 1,5 do
		for col = 2,colmax - 1 do
			if orbLayer[row][col]:hitTestPoint(event.touch.x, event.touch.y) then
				orbBoolean[row][col]= true
				last_row = row
				last_col = col
			end
		end
	end
end

function sakuClass:orbCount(event)
	for row = 1,5 do
		for col = 1,colmax do
			if orbId[row][col] ~= orbId[last_row][last_col] then
				orbBoolean[row][col] = false
				--orbBoolean[last_row][last_col] = false
			end
			if orbBoolean[row][col] == true then
				if orbId[row][col] == 1 then
					blueOrb = blueOrb + 1
					print("blue = "..blueOrb)
				elseif orbId[row][col] == 2 then
					greenOrb = greenOrb + 1
					print("green = "..greenOrb)
				elseif orbId[row][col] == 3 then
					yellowOrb = yellowOrb + 1
					print("yellow = "..yellowOrb)
				elseif orbId[row][col] == 4 then
					redOrb = redOrb + 1
					print("red = "..redOrb)
				end
				orbBoolean[row][col] = false 
			end
		end
	end
end