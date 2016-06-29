-- The orb class

local TEX = require "src/res/textures"
local Misc = require "src/helper/MiscClass"

OrbClass = Core.class(Sprite)

function OrbClass:init(color, row, col)
	--self:addChild(Bitmap.new(Texture.new("graphics/sakuOrb/" .. tostring(color) .. ".png")))
	self:addChild(Bitmap.new(TEX["ORB_"..color]))
	
	self.color = color
	self.row = row
	self.col = col
	self.isLinked = false
	self.nextX = 0
	self.nextY = 0
	
	stage:addEventListener("MOVE_ORB", self.onMoveOrb, self)
end

function OrbClass:changeColor()
	--self:removeChildAt(1)
	
	self.color = math.random(4)
	--self:addChild(Bitmap.new(Texture.new("graphics/sakuOrb/" .. self.color .. ".png")))
	self:getChildAt(1):setTexture(TEX["ORB_"..color])
end

function OrbClass:onMoveOrb(event)
	local row, col = self.row, self.col
	
	if col < 3 then
		while true do
			if col ~= 3 and event.table[row][col + 1] == false then
				if col > 0 then
					event.table[row][col] = false
				end
				
				col = col + 1
				event.table[row][col] = true
				self.col = col
				
				self.nextX = self.nextX + 64
			else
				break
			end
		end		
	elseif col > 5 then
		while true do
			if col ~= 5 and event.table[row][col - 1] == false then
				if col < 8 then
					event.table[row][col] = false
				end
			
				event.table[row][col] = false
				col = col - 1
				event.table[row][col] = true
				self.col = col
				
				self.nextX = self.nextX - 64
			else
				break
			end
		end
	elseif col == 4 and row > 1 then
		while true do
			if row ~= 1 and event.table[row - 1][col] == false then
				if row < 6 then
					event.table[row][col] = false
				end
			
				row = row - 1
				event.table[row][col] = true
				self.row = row
				
				self.nextY = self.nextY - 64
			else
				break
			end
		end
	end
end
