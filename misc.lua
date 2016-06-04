local misc = {}

function misc.isOverbound(obj)
	return obj:getX() < -obj:getWidth()
end

return misc