--[dirt start]--
local dirtClass = {}

function dirtClass.createDirt()
	--[[
	grasslayer = {}
	for i = 1,6,1 do
		grasslayer[i] = {}
		for j = 1,6,1 do	
			grasslayer[i][j] = Bitmap.new(Texture.new("background/tile_grass.png"))
			grasslayer[i][j]:setX((j - 1) * grasslayer[i][j]:getWidth() - 50)
			grasslayer[i][j]:setY(210)
			stage:addChild(grasslayer[i][j])
		end
	end]]

	lowerLayer={}
	for i = 1,6,1 do
		lowerLayer[i] = {}
		for j = 1,6,1 do
			if i == 1 then
				lowerLayer[i][j] = Bitmap.new(Texture.new("background/tile_grass.png"))
				lowerLayer[i][j]:setX((j - 1) * lowerLayer[i][j]:getWidth() - 50)
				lowerLayer[i][j]:setY(210)
				stage:addChild(lowerLayer[i][j])
			end
		
			lowerLayer[i][j] = Bitmap.new(Texture.new("background/tile_dirt.png"))
			lowerLayer[i][j]:setX((j - 1) * lowerLayer[i][j]:getWidth() -50)
			lowerLayer[i][j]:setY(210 + i * 70)
			stage : addChild(lowerLayer[i][j])
		end
	end
end

return dirtClass
--[dirt end]--