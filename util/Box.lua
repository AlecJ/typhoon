-- Box.lua
-- a class that holds a x, y, width, and height
-- ERROR [aaa] you cannot use multiple constructors with the same name

local Point = require("util.Point")

local Box = {}
Box.__index = Box -- error handling

-- constructor for 4 integers
function Box.new(x, y, w, h)
	self = setmetatable({}, Box)
	self.x = x
	self.y = y
	self.w = w
	self.h = h
	return self
end

-- constructor for two points
-- ERROR [aaa] you cannot use multiple constructors with the same name
-- function Box.new(pointa, pointb)
-- 	self = setmetatable({a = posx, b = posy}, Box)
-- 	return self
-- end

-- shifts a point over by a given x and y
function Box.move(rect, newx, newy)
	rect.x = rect.x + newx
	rect.y = rect.y + newy
end

return Box