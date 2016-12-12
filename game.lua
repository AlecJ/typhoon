-- game.lua
-- game class for project "typhoon"
-- two players will control one of the two characters on the screen
-- as the beat (of the active song) hits, each player will shoot a projectile
-- along with the beat, walls that fill a single grid space (hexagonal) will grow outward and form new walls
-- walls can be destroyed by players shooting them

local game = {}

function game.load(world)
	world.init()
	--song = love.audio.newSource("kicks.mp3")
end

-- handles a game tick
function game.update(dt, world)
	game.beat(dt, world)
	-- update movement of world objects
	world.move(dt)
	-- check for any collisions in the game world
	world.collide()
end

local elapsed_time = 0
local count = 0
-- handles the rythym element of the game, triggers certain events on each beat
function game.beat(dt, world)
	if start then
		elapsed_time = elapsed_time + dt
		if elapsed_time > bpq then
			elapsed_time = 0
			count = count + 1
			-- every half note, do the following
			if count % 1 == 0 then
				Player.shoot(world.player1, world)	
			end

			-- every beat, do the following
			if count % 4 == 0 then
				--Player.shoot(world.player1, world)	

			end
			-- every four beats, perform the following
			if count % 16 == 0 then
				Hex.grow(world)
			end
		end
	end
end

return game