-- input.lua
-- handles all key events, updates player or world position
local input = {}

function input.handleInput(dt, world)
	-- player is trying to move left
	if love.keyboard.isDown('f') then
		start = true
	end
end

return input