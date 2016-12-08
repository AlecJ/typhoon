-- game.lua
-- game class for project "typhoon"
-- two players will control one of the two characters on the screen
-- as the beat (of the active song) hits, each player will shoot a projectile
-- along with the beat, walls that fill a single grid space (hexagonal) will grow outward and form new walls
-- walls can be destroyed by players shooting them

local game = {}
local elapsed_time = 0


function game.load(world)
	world.init()
end

-- handles a game tick
function game.update(dt, world)
	if start then
		elapsed_time = elapsed_time + dt
		if elapsed_time > speed then
			elapsed_time = 0
			Hex.grow(world)
		end
	end
end

return game