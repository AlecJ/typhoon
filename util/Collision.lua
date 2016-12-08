-- Collision.lua
-- utility class that handles collision between objects

local Collision = {}

-- checks the overlap of two rectangles given 4 pts (top left and bottom right of each rectangle)
-- return true if the rectangles overlap
function Collision.rectOverlap(recta, rectb)
	return recta.x < rectb.x + rectb.w and 
	recta.x + recta.w > rectb.x and 
	recta.y < rectb.y + rectb.h and 
	recta.y + recta.h > rectb.y
end

-- takes a box and a point and decides if the box contains the point
-- returns a boolean to Fence.addGate()
function Collision.pointinRect(rect, x, y)
	return rect.x < x and
	rect.x + rect.w > x and
	rect.y < y and 
	rect.y + rect.h > y
end

return Collision