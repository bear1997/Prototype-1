local DirtClass = {}

function DirtClass.createDirt()
	dirtLayer={}
	for i = 1,5,1 do
		dirtLayer[i] = {}
		for j = 1,7,1 do
			if i == 1 then
				dirtLayer[i][j] = Bitmap.new(Texture.new("graphics/background/tile_grass.png"))
				dirtLayer[i][j]:setX((j - 1) * dirtLayer[i][j]:getWidth() - 44)
				dirtLayer[i][j]:setY(320 + (i - 1) * 64)
				stage:addChild(dirtLayer[i][j])
			else
				dirtLayer[i][j] = Bitmap.new(Texture.new("graphics/background/tile_dirt.png"))
				dirtLayer[i][j]:setX((j - 1) * dirtLayer[i][j]:getWidth() - 44)
				dirtLayer[i][j]:setY(320 + (i - 1) * 64)
				stage : addChild(dirtLayer[i][j])
			end			
		end
	end
end

return DirtClass
