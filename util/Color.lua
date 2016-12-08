-- color.lua
-- utility functions that help caluclate colors

local Color = {}

-- constructor for a color
function Color.new(red, green, blue)
	local self = setmetatable({}, color)
	self.r, self.g, self.b = red, green, blue
	return self
end

-- given two colors in rgb, a number of shades, and an index
-- return the rgb shade at the given index
function Color.gradient(colora, colorb, num_shades, index)
	local newColor = {}
	newColor.r = (colora.r - colorb.r) / num_shades * index + colora.g
	newColor.g = (colora.g - colorb.g) / num_shades * index + colora.b
	newColor.b = (colora.b - colorb.b) / num_shades * index + colora.b
	return newColor
end

return Color