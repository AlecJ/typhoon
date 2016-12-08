-- Love2d Game by Alec Jordan
-- Dec. 2016

-- open all classes to project files
Box = require("util.Box")
Color = require("util.Color")
Point = require("util.Point")
Hex = require("Hex")
List = require("util.List")

local game = require("game")
local render = require("render")
local world = require("world")
local input = require("input")

-- window size
love.window.setMode(1080, 720)

-- global variables
grid_size = 25
game_area = .1
dev = false
speed = 1.83
start = false

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