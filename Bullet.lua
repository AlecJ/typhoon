-- Bullet.lua
-- created on player input, can damage other players

Bullet = {}

local bullet_color = Color.new(255, 0, 0)
local bullet_speed = 1000

function Bullet.new(x, y, angle)
	local self = setmetatable({}, Bullet)
	self.x = x
	self.y = y
	self.angle = angle
	self.bb = Box.new(self.x-5, self.y-5,10,10)
	return self
end

-- moves the bullet along its trajectory 
-- also update the life of each bullet
function Bullet.move(self, dt)
	local dx, dy = dt * math.cos(self.angle), dt * math.sin(self.angle)
	self.x = self.x + bullet_speed * dx
	self.y = self.y + bullet_speed * dy
	Box.move(self.bb, bullet_speed * dx, bullet_speed * dy)
end

-- check if the bullet hits a player or a wall
function Bullet.collide(self, world)
	-- for every non walled grid space, check to see if the bullet is close
end

-- renders each bullet
function Bullet.render(self)
	love.graphics.setColor(bullet_color.r, bullet_color.g, bullet_color.b)
	love.graphics.circle('fill', self.x, self.y, 5)
	love.graphics.rectangle('line', self.bb.x, self.bb.y, self.bb.w, self.bb.h)
end

return Bullet