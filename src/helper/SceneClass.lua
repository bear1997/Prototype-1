local SceneClass = {}

local sKnight, sArcher, sThief, sCaster = nil, nil, nil, nil

function SceneClass.chooseChars()
	sKnight = Shape.new()
	sKnight:setFillStyle(Shape.SOLID, 0xff0000, 1)
	sKnight:beginPath()
	sKnight:moveTo(0, 192)
	sKnight:lineTo(360, 64)
	sKnight:endPath()
	stage:addChild(sKnight)
end

return SceneClass