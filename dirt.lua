--[dirt start]--
local dirtclass = {}
function dirtclass.dirt()
	grasslayer = {}
	for i = 1,6,1 do
		grasslayer[i] = {}
		for j = 1,6,1 do	
			grasslayer[i][j] = Bitmap.new(Texture.new("background/tile_grass.png"))
			grasslayer[i][j]:setX((j - 1) * grasslayer[i][j]:getWidth() - 50)
			grasslayer[i][j]:setY(210)
			stage:addChild(grasslayer[i][j])
		end
	end

	lowerlayer={}
	for i = 1,6,1 do
		lowerlayer[i] = {}
		for j = 1,6,1 do	
			lowerlayer[i][j] = Bitmap.new(Texture.new("background/tile_dirt.png"))
			lowerlayer[i][j]:setX((j - 1) * lowerlayer[i][j]:getWidth() -50)
			lowerlayer[i][j]:setY(210 + i * 70)
			stage : addChild(lowerlayer[i][j])
		end
	end
end

return dirtclass
--[dirt end]--