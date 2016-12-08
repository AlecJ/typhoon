-- Coord.lua
-- coordinate class
-- holds an x position and a y position

local Point = {}
Point.__index = Point -- error handling

-- constructor
function Point.new(posx, posy)
	self = setmetatable({x = posx, y = posy}, Point)
	return self
end

-- shifts a point over by a given x and y
function Point.move(self, newx, newy)
	self.x = self.x + newx
	self.y = self.y + newy
end

-- scale the point by the given factor
function Point.scale(self, factor)
	self.x = self.x * factor
	self.y = self.y * factor
end

return Point