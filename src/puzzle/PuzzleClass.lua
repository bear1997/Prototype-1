PuzzleClass = Core.class(Sprite)

local Misc = require "src/helper/MiscClass"
local CONST = require "src/res/constants"

local BattleEngineClass = require "src/core/BattleEngineClass"

local orbLayer = {}
local orbTable = {}

local orbColor = {}

local colmax = 7
-------------------------------------------------------------------------------------------

-- Setup everything at the start
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

local lastRow, lastCol, isEnded, isMoving, moveCounter, diffRow, diffCol = 0, 0, false, false, 0, 0, 0
local orbStack = {}

-- Remove the linked value from all orbs
function PuzzleClass:resetLink()
	for row = 1,5,1 do
		for col = 1,colmax,1 do
			orbLayer[row][col].isLinked = false
		end
	end
	orbColor = 0
end

-- Convenient method to set the moving flag to false
function PuzzleClass:setMoving()
	isMoving = false
end

-- Fill the empty gap by pushing newly placed orbs to the gap, may loop multiple times if necessary
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

-- Place the hidden linked orbs to their new places, respectively
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

-- Hide all orbs
function PuzzleClass:showAllOrbs()
	for row = 1,5 do
		for col = 1,colmax do			
				--GTween.new(orbLayer[row][col], 0.5, {alpha = 100}, { ease = easing.inBack })
				orbLayer[row][col]:setAlpha(1)
		end
	end
end

-- Hide all orbs
function PuzzleClass:hideAllOrbs()
	for row = 1,5 do
		for col = 1,colmax do
				--orbLayer[row][col]:setVisible(true)
				--GTween.new(orbLayer[row][col], 0.5, {alpha = 0}, { ease = easing.inBack })
				orbLayer[row][col]:setAlpha(0)
		end
	end
end

-- Hide the linked orbs only
function PuzzleClass:hideOrbs()
	for row = 1,5 do
		for col = 1,colmax do
			if orbLayer[row][col].isLinked == true then
				GTween.new(orbLayer[row][col], 0.5, {alpha = 0}, { ease = easing.inBack })
			end				
		end
	end
	self:setColorAction()
	removeTimer:start()
end

-- Detect the orbs that receive input, and set the orbs to become linked
function PuzzleClass:onMove(event)
	if isMoving == false then
		for row = 1,5 do
			for col = 1,colmax do
				if orbLayer[row][col]:hitTestPoint(event.touch.x, event.touch.y) and orbLayer[row][col].col > 1
				and orbLayer[row][col].col < colmax then
					
					if lastRow == 0 and lastCol == 0 then
						lastRow, lastCol = row, col
					end
					
					diffRow, diffCol = math.abs(orbLayer[row][col].row - orbLayer[lastRow][lastCol].row),
										math.abs(orbLayer[row][col].col - orbLayer[lastRow][lastCol].col)
					
					if diffRow == 1 and diffCol == 1 then
						isEnded = true
						moveCounter = 0
						self:resetLink()
					end					
					
					if diffRow == 1 or diffCol == 1 then						
						if orbLayer[row][col].isLinked ~= false then
							print("link end")
							isEnded = true
							isMoving = true
							moveCounter = 0
							self:hideOrbs()			
						elseif orbLayer[lastRow][lastCol].color ~= orbLayer[row][col].color then
							print("color end")
							isEnded = true
							if moveCounter > 1 then
								isMoving = true
								self:hideOrbs()
							else
								self:resetLink()
							end
							moveCounter = 0
						end	
					end
					
					if isEnded ~= true then
						if orbLayer[row][col].isLinked ~= true then
							orbColor = orbLayer[row][col].color
							
							moveCounter = moveCounter + 1
							orbLayer[row][col].isLinked = true
							lastRow, lastCol = row, col
						end
					else
						lastRow, lastCol = 0, 0
					end
				elseif orbLayer[row][col]:hitTestPoint(event.touch.x, event.touch.y) and moveCounter > 0
					and (orbLayer[row][col].col <= 1 or orbLayer[row][col].col >= colmax) then
					isEnded = true
					moveCounter = 0
					self:resetLink()
				end
			end
		end
	end
end

-- Detect the end of input event, and also process the linking process of orbs
function PuzzleClass:onMoveEnd()
	if isMoving == false then
		if isEnded == false then
			if moveCounter > 1 then
				print("manual end")
				lastRow, lastCol = 0, 0
				isMoving = true				
				self:hideOrbs()
				moveCounter = 0
			else
				lastRow, lastCol = 0, 0
				isMoving = false
				moveCounter = 0
				self:resetLink()
			end
		end
	end
	isEnded = false
end

-- Decide the current action of player to be performed, depending on the orbs color
function PuzzleClass:setColorAction()
	if orbColor == CONST.ORB_RED then
		BattleEngineClass.attackEnemy(Player, moveCounter)
	end
end

movedTimer:addEventListener(Event.TIMER, PuzzleClass.setMoving)
removeTimer:addEventListener(Event.TIMER, PuzzleClass.supplyOrb)
