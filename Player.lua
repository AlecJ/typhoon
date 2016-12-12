-- Player.lua
-- player class that controls movement, collision, and rendering

local Player = {}
local player_size = 25
local player_color = Color.new(255, 200, 0)
local player_speed = 500
local player_health = 100

-- constructor
function Player.new(x, y)
	local self = setmetatable({}, Player)
	self.x = x
	self.y = y
	self.hp = player_health
	self.bb = Box.new(self.x - player_size / 2, self.y - player_size / 2, player_size, player_size)
	return self
end

-- given input and world information, update the player position
function Player.move(self, dt, world)
	if love.keyboard.isDown('w') and not Player.collide(self, 0, -player_speed * dt, world) then
		self.y = self.y - player_speed * dt
	end
	if love.keyboard.isDown('a') and not Player.collide(self, -player_speed * dt, 0, world) then
		self.x = self.x - player_speed * dt
	end
		if love.keyboard.isDown('s') and not Player.collide(self, 0, player_speed * dt, world) then
		self.y = self.y + player_speed * dt
	end
	if love.keyboard.isDown('d') and not Player.collide(self, player_speed * dt, 0, world) then
		self.x = self.x + player_speed * dt
	end
end

-- allows the player to shoot bullets toward the user's cursor
function Player.shoot(self, world)
	local dx, dy = love.mouse.getPosition()
	dx = dx - self.x
	dy = dy - self.y
	local theta = math.atan2(dy, dx)
	table.insert(world.bullets, Bullet.new(self.x, self.y, theta))
end

-- check if a new position would cause the player to run into a hexagon
function Player.collide(self, dx, dy, world)
	result = false
	-- compare overlap with every active hexagon
	for i, row in ipairs(world.hexagons) do
		for j, hex in ipairs(row) do
			if hex.generator then
				result = result or Collision.rectOverlap(Box.new(self.x + dx, self.y + dy, player_size, player_size), hex.bb)
			end
		end
	end
	return result
end



-- renders the player
function Player.render(self)
	love.graphics.setColor(player_color.r, player_color.g, player_color.b)
	love.graphics.rectangle('fill', self.x - player_size / 2, self.y - player_size / 2, player_size, player_size)
end

return Player