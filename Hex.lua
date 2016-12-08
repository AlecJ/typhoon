-- Hex.lua
-- Hexagon class that represents a grid space in the game
-- this requires its own class because grid spaces can change between non-blocking and blocking walls

Hex = {}
local line = Color.new(40, 200, 255)

-- constructor for the hex class
function Hex.new(x, y)
	local self = setmetatable({}, Hex)
	self.x, self.y = x, y
	self.hp = 100
	self.perm = false -- if true, can never be broken
	self.generator = false -- if true, after an interval, the surrounding hexagons will grow into walls
	return self
end

-- called by the collision class
-- return the bounding boxes for the object if the wall is active
function Hex.collide(self)
	boxes = {}
	-- add 3 boxes for each rectangle

end

-- select every active hexagon and make non-active neighbors active
function Hex.grow(world)
	newHexes = {}
	-- for each active hexagon, add non-active neighbors that can be made active (no walls)
	for i, hexagon in ipairs(world.hexagons) do
		-- find each generator
		if hexagon.generator then
			-- add qualifying neighbors
			for j, neighbor in ipairs(Hex.getNeighbors(hexagon, world)) do
				if not neighbor.perm and not neighbor.generator then
					-- make sure it is not a duplicate that we have already added
					if not Hex.inList(newHexes, neighbor) then
						table.insert(newHexes, neighbor)
					end
				end
			end
		end
	end
	-- update all new hexagons
	for x, hexagon in ipairs(newHexes) do
		Hex.activate(hexagon)
	end
end

-- updates the stats of a hexagon to make it active
function Hex.activate(self)
	self.hp = 100
	self.generator = true
end

-- given a hexagon, return its neighbors
function Hex.getNeighbors(self, world)
	local neighbors = {}
	for i, hexagon in ipairs(world.hexagons) do
		-- if self, skip
		if self.x == hexagon.x and self.y == hexagon.y then
		-- every hexagon is sqrt(3) apart
		elseif math.abs(self.x - hexagon.x) <= math.sqrt(3) * grid_size + 1 and 
			math.abs(self.y - hexagon.y) <= math.sqrt(3) * grid_size + 1 then
			table.insert(neighbors, hexagon)
		end
	end
	return neighbors
end

-- given a list of hexagons and a hexagon
-- decides if the hexagon is already in the list
-- returns a boolean
function Hex.inList(list, hex)
	local result = false
	for i, entry in ipairs(list) do
		result = result or Hex.equals(entry, hex)
	end
	return result
end

-- given two hexagons, decide if they are equal
-- returns a boolean
function Hex.equals(hex1, hex2)
	return hex1.x == hex2.x and hex1.y == hex2.y
end

-- draws a given hexagon
function Hex.render(self)
	love.graphics.setColor(line.r, line.g, line.b)
	local s = grid_size
	local height = math.sqrt(3)/2*s
	local vertices = {self.x - s, self.y, 
		self.x - .5*s, self.y -height, 
		self.x + .5*s, self.y - height,
		self.x + s, self.y,
		self.x + .5*s, self.y + height, 
		self.x - .5*s, self.y + height}
	if self.perm then
		love.graphics.setColor(255, 255, 255)
		love.graphics.polygon('fill', vertices)
	elseif self.generator then
		love.graphics.polygon('fill', vertices)
	else
		love.graphics.polygon('line', vertices)
	end
end

return Hex