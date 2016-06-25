local SceneClass = {}

SKnight, SArcher, SThief, SCaster = nil, nil, nil, nil

function SceneClass.chooseChars()
	SKnight = Shape.new()
	SKnight:setFillStyle(Shape.SOLID, 0xff0000, 1)
	SKnight:beginPath()
	SKnight:moveTo(0,0)
	SKnight:lineTo(100, 0)
	SKnight:lineTo(100, 100)
	SKnight:lineTo(0, 100)
	SKnight:lineTo(0, 0)
	SKnight:endPath()
	SKnight:setPosition(0, 150)
	stage:addChild(SKnight)
	--[[
	SKnight = Shape.new()
	SKnight:setFillStyle(Shape.SOLID, 0xff0000, 1)
	SKnight:beginPath()
	SKnight:moveTo(0, 192)
	SKnight:lineTo(360, 64)
	SKnight:endPath()]]
end

return SceneClass