local misc = {}

function misc.isOverbound(obj)
	return obj:getX() < -obj:getWidth()
end

function misc.bringToFront(obj)
	stage:addChild(obj)
end

return misc