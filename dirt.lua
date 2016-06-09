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

	dirtLayer={}
	for i = 1,6,1 do
		dirtLayer[i] = {}
		for j = 1,6,1 do
			if i == 1 then
				dirtLayer[i][j] = Bitmap.new(Texture.new("g_background/tile_grass.png"))
				dirtLayer[i][j]:setX((j - 1) * dirtLayer[i][j]:getWidth() - 50)
				dirtLayer[i][j]:setY(200)
				stage:addChild(dirtLayer[i][j])
			end
		
			dirtLayer[i][j] = Bitmap.new(Texture.new("g_background/tile_dirt.png"))
			dirtLayer[i][j]:setX((j - 1) * dirtLayer[i][j]:getWidth() -50)
			dirtLayer[i][j]:setY(200 + i * 70)
			stage : addChild(dirtLayer[i][j])
		end
	end
end

return dirtClass
--[dirt end]--