--[background start]--
local background = Bitmap.new(Texture.new("background/bg_grass.png"))
stage : addChild(background)
--[background end]--

local dirt = require("dirt")
dirt.dirt()

stage:setOrientation(Stage.PORTRAIT)
stage:addChild(grassclass.new())

stage:setOrientation(Stage.PORTRAIT)
stage:addChild(cloudclass.new())

stage:setOrientation(Stage.PORTRAIT)
local magician = walkingclass.new()
stage:addChild(magician)
