--[puzzle start]--
sakuClass = Core.class(Sprite)

saku = {}
local i = 1
local index

timer = Timer.new(500,9)

--[calling function]--
function sakuClass:init(event)
	sakuClass:orbrespwan()
	stage:addEventListener(Event.MOUSE_DOWN,sakuClass.onTouches)
end

function sakuClass:onTouches(event)
	print("DONE")
	stage:addEventListener(Event.ENTER_FRAME, sakuClass.onEnterFrame, self)
end

function sakuClass:respawntimer(event)
	sakuClass:orbrespwan()
	stage:addEventListener(Event.ENTER_FRAME, sakuClass.onEnterFrame, self)
end

timer:addEventListener(Event.TIMER,sakuClass.respawntimer, self)
--[end of call]--


--[function]--
function sakuClass:orbrespwan()
	local initialX = 300
	local initialY = 210
	
	for row = 0,3 do
		saku[i] = Bitmap.new(Texture.new("SakuOrb/"..tostring(math.random(4))..".png"))
		stage:addChild(saku[i])
		if row == 0 then	
			saku[i]:setX(initialX)
			saku[i]:setY(initialY)
		else
			saku[i]:setX(initialX)
			saku[i]:setY(initialY + row * 70)
		end
		i = i + 1
	end
end

function sakuClass:onEnterFrame(event)	
	local orbspeed = 300
	for i = 1,4,1 do
		local x = saku[i]:getX() - orbspeed * event.deltaTime
		saku[i]:setX(x)
	end
	timer:start()
end
--[function end]--