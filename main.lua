-- Love2d Game by Alec Jordan
-- Dec. 2016

-- open all classes to project files
Box = require("util.Box")
Color = require("util.Color")
Point = require("util.Point")
List = require("util.List")
Hex = require("Hex")
Player = require("Player")
Bullet = require("Bullet")
Collision = require("util.Collision")

local input = require("input")
local game = require("game")
local render = require("render")
local world = require("world")

-- window size
love.window.setMode(1080, 720)

-- global variables
grid_size = 25
game_area = .1
dev = false
bpm = 130
bps = 60/bpm
bpq = bps/4
start = false

hex_height = math.ceil(love.graphics.getHeight() / (math.sqrt(3) * grid_size))
hex_width = math.ceil((love.graphics.getWidth() / grid_size + 1) / 3) * 2

function love.load()
	game.load(world)

end

function love.update(dt)
	input.handleInput(dt, world)
	game.update(dt, world)
end

function love.draw()
	render.draw(world)
end