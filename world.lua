-- world.lua
-- stores all of the world and object data of the game

local world = {}

-- generate a grid space to cover the screen
function world.init()
	-- a 2d array of the hexagons
	world.hexagons = {}

	-- an array of active bullets
	world.bullets = {}

	-- two player objects
	world.player1 = Player.new(love.graphics.getWidth()/4, love.graphics.getHeight() / 2)
	world.player2 = Player.new(love.graphics.getWidth()*3/4, love.graphics.getHeight() / 2)
	
	-- the rows are staggered so we need two hexagons are created for each x
	for dy = 0, hex_height do
		local row = {}
		for dx = 0, hex_width do -- maybe add a -1 to this
			local x = dx * 1.5 * grid_size
			local y = dy * math.sqrt(3) * grid_size + math.fmod(dx, 2) * math.sqrt(3)/2 * grid_size
			local newHex = Hex.new(x, y, dx + 1, dy + 1)
			if dx == 0 or dx >= hex_width - 1 or dy == 0 or dy >= hex_height - 1 then
				--x - grid_size <= 0 or x + grid_size >= love.graphics.getWidth() or y - grid_size <= 0 or y + grid_size >= love.graphics.getHeight() then
				newHex.perm = true
			end
			table.insert(row, newHex)
		end
		table.insert(world.hexagons, row)
	end
	--have all hexagons add neighbors
	for i, row in ipairs(world.hexagons) do
		for j, hexagon in ipairs(row) do
			Hex.addNeighbors(hexagon, world)
		end
	end

	-- make the center hexagon a generator
	local center = world.hexagons[math.ceil(hex_height/2)][math.ceil(hex_width / 2)]
	center.generator = true
	center.perm = true
end

-- updates the location of all world objects
function world.move(dt)
	-- move all of the bullets
	for i, bullet in ipairs(world.bullets) do
		Bullet.move(bullet, dt)
		-- if any bullets are offscreen, remove them
		if not Collision.rectOverlap(Box.new(0, 0, love.graphics.getWidth(), love.graphics.getHeight()), bullet.bb) then
			table.remove(world.bullets, i)
		end
	end
end

-- checks for any collisions during this tick
function world.collide()
	-- check if any players are hit by bullets
	-- check if any hexagons are hit by bullets
	for i, bullet in ipairs(world.bullets) do
		for j, row in ipairs(world.hexagons) do
			for k, hexagon in ipairs(row) do
				-- only deal with hexagons on the edges
				if hexagon.generator and not hexagon.perm then
					if Collision.rectOverlap(bullet.bb, hexagon.bb) then
						-- if so, remove the bullet and destroy the grid space
						table.remove(world.bullets, i)
						Hex.damage(hexagon, 50)
					end
				end
			end
		end
	end

end

return world