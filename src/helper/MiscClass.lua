-- Miscellaneous methods and utitlies can be found here

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

--[[Credit: https://www.ecse.rpi.edu/Homepages/wrf/Research/Short_Notes/pnpoly.html (Orginal code is C version)
	nvert: Number of vertices in the polygon. Whether to repeat the first vertex at the end has been discussed in the article referred above.
	vertx, verty: Arrays containing the x- and y-coordinates of the polygon's vertices.
	testx, testy: X- and y-coordinate of the test point.]]
function MiscClass.checkPointInShape(nvert, vertx, verty, testx, testy)
	local i, j, c = 1, nvert, false
    for i = 1, nvert do
		if (((verty[i]>testy) ~= (verty[j]>testy)) and 
		(testx < (vertx[j]-vertx[i]) * (testy-verty[i]) / (verty[j]-verty[i]) + vertx[i])) then
			c = not c
		end
		j = i
	end
	return c
end

return MiscClass