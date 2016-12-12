-- Hex.lua
-- Hexagon class that represents a grid space in the game
-- this requires its own class because grid spaces can change between non-blocking and blocking walls

Hex = {}
local line = Color.new(40, 200, 255)

-- constructor for the hex class
function Hex.new(x, y, ix, iy)
	local self = setmetatable({}, Hex)
	self.x, self.y = x, y
	self.ix, self.iy = ix, iy -- important for determining neighbors
	self.hp = 100
	self.perm = false -- if true, can never be broken
	self.generator = false -- if true, after an interval, the surrounding hexagons will grow into walls
	self.neighbors = {}
	self.walled = false -- if surrounded by active walls, don't check several functions
	self.bb = Box.new(self.x - grid_size, self.y - grid_size, 2*grid_size, 2*grid_size)
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
	local newHexes = {}
	local myNeighbors = {}
	-- for each active hexagon, add non-active neighbors that can be made active (no walls)
	for i, row in ipairs(world.hexagons) do
		for j, hexagon in ipairs(row) do
		-- find each generator
			if hexagon.generator and not hexagon.walled then
				-- add qualifying neighbors
				for j, neighbor in ipairs(hexagon.neighbors) do
					if not neighbor.perm and not neighbor.generator then
						if Collision.rectOverlap(neighbor.bb, world.player1.bb) then
							print("yepppp")
						end
						-- make sure it is not a duplicate that we have already added
						if not Hex.inList(newHexes, neighbor) then
							table.insert(myNeighbors, neighbor)
						end
					end
				end
				-- if no neighbors qualify, we are walled
				if #myNeighbors == 0 then
					hexagon.walled = true
				end
				-- copy over all of the neighbors to the concatted list
				for t = 0, #myNeighbors do
					table.insert(newHexes, myNeighbors[t])
				end
				-- empty the local list
				myNeighbors = {}
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

-- updates the health of a hexagon if it takes damage
function Hex.damage(self, dmg)
	self.hp = self.hp - dmg
	-- if hp is below zero, deactivate the hex
	if self.hp <= 0 then
		self.generator = false
	end
end

-- given a hexagon, find its neighbors
-- could be more efficient if neighbors add eachother at the same time
function Hex.addNeighbors(self, world)
	local allHex = world.hexagons
	-- odd and even x have different means for finding neighbors
	possibles = {}
	local x, y = self.ix, self.iy
	if x % 2 == 1 then
		table.insert(possibles, {x-1, y-1})
		table.insert(possibles, {x+1, y-1})
		table.insert(possibles, {x-1, y})
		table.insert(possibles, {x+1, y})
	else
		table.insert(possibles, {x-1, y})
		table.insert(possibles, {x+1, y})
		table.insert(possibles, {x-1, y+1})
		table.insert(possibles, {x+1, y+1})
	end
	table.insert(possibles, {x, y-1})
	table.insert(possibles, {x, y+1})
	-- check if each possible neighbor is legal
	for i, pos in ipairs(possibles) do
		-- if its on a wall do not try to index it
		if not (pos[1] <= 1 or pos[1] >= hex_width or pos[2] <= 1 or pos[2] >= hex_height) then
			--print(pos[1] .. " " .. pos[2])
			table.insert(self.neighbors, world.hexagons[pos[2]][pos[1]])
		end
	end
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
	return hex1.x == hex2.x and hex1.y == hex2.y and
	hex1.ix == hex2.ix and hex1.iy == hex2.iy
end

-- draws a given hexagon
-- currently needs to be updated with new rendering
function Hex.render(self)
	love.graphics.setColor(line.r, line.g, line.b)
	local s = grid_size
	local cx, cy = self.x, self.y
	local height = math.sqrt(3)/2*s
	local vertices = {cx - s, cy, 
		cx - .5*s, cy -height, 
		cx + .5*s, cy - height,
		cx + s, cy,
		cx + .5*s, cy + height, 
		cx - .5*s, cy + height}
	if self.walled then
		love.graphics.setColor(255, 255, 255)
		love.graphics.polygon('fill', vertices)
	elseif self.generator then
		love.graphics.polygon('fill', vertices)
	else
		love.graphics.polygon('line', vertices)
	end
	-- draws the bounding box
	if dev then
		love.graphics.rectangle('line', self.bb.x, self.bb.y, self.bb.w, self.bb.h)
	end
end

return Hex