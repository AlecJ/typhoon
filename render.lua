-- render.lua
-- draws the world objects and background grid

render = {}

local background = Color.new(50, 50, 50)

-- renders the game world
function render.draw(world)
	-- draw the background shade
	love.graphics.setColor(background.r, background.g, background.b)
	love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

	-- draw the grid
	render.grid(world)

	-- draw a bounding box of the play area
	if dev then 
		local line = Color.new(255, 255, 255)
		love.graphics.setColor(line.r, line.g, line.b)
		love.graphics.rectangle('fill', love.graphics.getWidth() / 2 - 3, love.graphics.getHeight() / 2 - 3, 6, 6)
		love.graphics.rectangle('line', love.graphics.getWidth() * game_area, love.graphics.getHeight() * game_area,
			love.graphics.getWidth() * (1 - 2 * game_area), love.graphics.getHeight() * (1 - 2 * game_area))
	end

	-- draw bullets
	for i, bullet in ipairs(world.bullets) do
		Bullet.render(bullet)
	end

	-- lastly, render the players
	Player.render(world.player1)
	Player.render(world.player2)
end

function render.grid(world)
	for i, row in ipairs(world.hexagons) do
		for j, hexagon in ipairs(row) do
			Hex.render(hexagon)
		end
	end
end

return render