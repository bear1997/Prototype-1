PuzzleClass = Core.class(Sprite)

local Misc = require("src/helper/MiscClass")

local orbLayer = {}
local orbTable = {}

local blueOrb = 0
local greenOrb = 0
local yellowOrb = 0
local redOrb = 0

local colmax = 7
-------------------------------------------------------------------------------------------
function PuzzleClass:init(event)
	local initialX = 230
	local initialY = 320
	
	for row = 1,5,1 do
		orbLayer[row] = {}
		orbTable[row] = {}
		for col = 1,colmax,1 do
			local color = math.random(4)
			orbLayer[row][col] = OrbClass.new(color, row, col)
			stage:addChild(orbLayer[row][col])
			orbTable[row][col] = true
			
			orbLayer[row][col]:setX((col - 1) * orbLayer[row][col]:getWidth() - 44)
			orbLayer[row][col]:setY(initialY + (row - 1) * 64)
		end
	end
		
	self:addEventListener(Event.TOUCHES_MOVE, PuzzleClass.onMove, self)
	self:addEventListener(Event.TOUCHES_END, PuzzleClass.onMoveEnd, self)
	
	stage:addEventListener(Event.KEY_DOWN, function(event)
		if event.keyCode == KeyCode.Q then
			print("start-------------------")
			for row = 1,5,1 do
				for col = 1,colmax,1 do
					print("row: "..orbLayer[row][col].row.." col: "..orbLayer[row][col].col.." alpha: "..orbLayer[row][col]:getAlpha())
				end
			end
			print("end---------------------")
		end
	end)
end
-------------------------------------------------------------------------------------------------------------

local movedTimer = Timer.new(510, 1)
local removeTimer = Timer.new(510, 1)

local last_row, last_col, is_ended, is_moving, move_counter, diff_row, diff_col = 0, 0, false, false, 0, 0, 0
local orbStack = {}

function PuzzleClass:resetLink()
	for row = 1,5,1 do
		for col = 1,colmax,1 do
			orbLayer[row][col].isLinked = false
		end
	end
end

function PuzzleClass:setMoving()
	is_moving = false
end

function PuzzleClass:fillSlot()
	local moveOrbEvent = Event.new("MOVE_ORB")
	local isFilled = false

	while isFilled ~= true do
		isFilled = true
		for row = 1,5,1 do
			for col = 1,colmax,1 do
				if orbTable[row][col] == false then
					isFilled = false
				end
			end
		end
	
		moveOrbEvent.layer = orbLayer
		moveOrbEvent.table = orbTable
		stage:dispatchEvent(moveOrbEvent)
	end
	
	for row = 1,5,1 do
		for col = 1,colmax,1 do
			if orbLayer[row][col].col < 4 then
				GTween.new(orbLayer[row][col], 0.5, {x = orbLayer[row][col].nextX}, { ease = easing.inBack })
			elseif orbLayer[row][col].col > 4 then
				GTween.new(orbLayer[row][col], 0.5, {x = orbLayer[row][col].nextX}, { ease = easing.inBack })
			else
				GTween.new(orbLayer[row][col], 0.5, {y = orbLayer[row][col].nextY}, { ease = easing.inBack })
			end
			orbLayer[row][col].nextX = orbLayer[row][col]:getX()
			orbLayer[row][col].nextY = orbLayer[row][col]:getY()
		end
	end
	
	movedTimer:start()
end

function PuzzleClass:supplyOrb()
	local r_row, r_col = 0, 0
	for row = 1,5 do
		for col = 1,colmax do
			if orbLayer[row][col].isLinked == true then
				r_row, r_col = orbLayer[row][col].row, orbLayer[row][col].col
				
				if r_col < 4 then
					orbLayer[row][col]:setX(-108)					
					orbLayer[row][col].col = 0
				elseif r_col > 4 then
					orbLayer[row][col]:setX(404)					
					orbLayer[row][col].col = 8
				else
					orbLayer[row][col]:setY(640)					
					orbLayer[row][col].row = 6
				end
				
				orbTable[r_row][r_col] = false
				orbLayer[row][col]:setAlpha(1)
				orbLayer[row][col].isLinked = false
				orbLayer[row][col]:changeColor()
			end			
			
			orbLayer[row][col].nextX = orbLayer[row][col]:getX()
			orbLayer[row][col].nextY = orbLayer[row][col]:getY()
		end
	end
	PuzzleClass:fillSlot()
end

function PuzzleClass:hideOrb()
	for row = 1,5 do
		for col = 1,colmax do
			if orbLayer[row][col].isLinked == true then
				GTween.new(orbLayer[row][col], 0.5, {alpha = 0}, { ease = easing.inBack })
			end				
		end
	end
	
	removeTimer:start()
end

function PuzzleClass:onMove(event)
	if is_moving == false then
		for row = 1,5 do
			for col = 1,colmax do
				if orbLayer[row][col]:hitTestPoint(event.touch.x, event.touch.y) and orbLayer[row][col].col > 1
				and orbLayer[row][col].col < colmax then
					
					if last_row == 0 and last_col == 0 then
						last_row, last_col = row, col
					end
					
					diff_row, diff_col = math.abs(orbLayer[row][col].row - orbLayer[last_row][last_col].row),
										math.abs(orbLayer[row][col].col - orbLayer[last_row][last_col].col)
					
					if diff_row == 1 and diff_col == 1 then
						is_ended = true
						move_counter = 0
						self.resetLink()
					end					
					
					if diff_row == 1 or diff_col == 1 then						
						if orbLayer[row][col].isLinked ~= false then
							print("link end")
							is_ended = true
							is_moving = true
							move_counter = 0
							self.hideOrb()						
						elseif orbLayer[last_row][last_col].color ~= orbLayer[row][col].color then
							print("color end")
							is_ended = true
							if move_counter > 1 then
								is_moving = true
								self.hideOrb()
							else
								self.resetLink()
							end
							move_counter = 0
						end	
					end
					
					if is_ended ~= true then
						if orbLayer[row][col].isLinked ~= true then
							move_counter = move_counter + 1
							orbLayer[row][col].isLinked = true
							last_row, last_col = row, col
						end
					else
						last_row, last_col = 0, 0
					end
				elseif orbLayer[row][col]:hitTestPoint(event.touch.x, event.touch.y) and move_counter > 0
					and (orbLayer[row][col].col <= 1 or orbLayer[row][col].col >= colmax) then
					print("forbidden column")
					is_ended = true
					move_counter = 0
					self.resetLink()
				end
			end
		end
	end
end

function PuzzleClass:onMoveEnd()
	if is_moving == false then
		if is_ended == false then
			if move_counter > 1 then
				print("manual end")
				last_row, last_col = 0, 0
				is_moving = true
				move_counter = 0
				self.hideOrb()
			end
		end
	end
	is_ended = false
end

movedTimer:addEventListener(Event.TIMER, PuzzleClass.setMoving)
removeTimer:addEventListener(Event.TIMER, PuzzleClass.supplyOrb)
