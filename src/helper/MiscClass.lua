local MiscClass = {}

function MiscClass.isOverbound(obj)
	return obj:getX() < -obj:getWidth()
end

function MiscClass.bringToFront(obj)
	stage:addChild(obj)
end

function MiscClass.checkBound(obj, x, y)
	if x > (obj.row - 1) * 64 + 20 and x < (obj.row - 1) * 64 + 20 + 64 and
	   y > (obj.col - 1) * 64 and y < (obj.col - 1) * 64 + 64 then
	   return true
	end
end

return MiscClass