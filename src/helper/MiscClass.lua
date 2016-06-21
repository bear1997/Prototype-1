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

function MiscClass.split(inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={} ; i=1
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                t[i] = str
                i = i + 1
        end
        return t
end

return MiscClass