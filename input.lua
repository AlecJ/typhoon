-- input.lua
-- handles all key events, updates player or world position
local input = {}

function input.handleInput(dt, world)
	-- pass player movement to the player class
	Player.move(world.player1, dt, world)

	-- begin beat sync once f is pressed
	if love.keyboard.isDown("f") then
		start = true
	end
end

return input