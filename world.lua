-- world.lua
-- stores all of the world and object data of the game

local world = {}

-- generate a grid space to cover the screen
function world.init()
	world.hexagons = {}
	local screenw, screenh = love.graphics.getWidth(), love.graphics.getHeight()
	local hex_height = screenh / math.sqrt(3) * grid_size
	local hex_width = (screenw / grid_size + 1) / 3
	for dy = 0, hex_height do
		for dx = 0, hex_width do
			for offset = 0, 1 do
				local newHex = Hex.new(dx * 3 * grid_size + 1.5 * grid_size * offset, 
					dy * math.sqrt(3) * grid_size + offset * math.sqrt(3)/2 * grid_size)
				-- if the hexagon touches the side of the screen, make it a permanent wall
				if newHex.x <= grid_size/2 or newHex.y <= grid_size/2 or newHex.x >= screenw - grid_size/2 or 
					newHex.y >= screenh - grid_size/2 then
					newHex.perm = true
				end
				-- get the center
				if math.abs(newHex.x - (screenw - 10) / 2) < grid_size and math.abs(newHex.y - (screenh - 10) / 2) < grid_size then
					world.center = newHex
					newHex.perm = true
					newHex.generator = true

				end
				table.insert(world.hexagons, newHex)
			end
		end
	end
end

return world