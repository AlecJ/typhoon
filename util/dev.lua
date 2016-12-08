-- dev.lua
-- provides developer functions

local dev = {string = "", value = "", string2 = "", value2 = "", string3 = "", value3 = "", string4 = "", value4 = ""}

function dev.print(string, value)
	dev.string = string
	dev.value = value
end

function dev.printmore(string, value, string2, value2, string3, value3, string4, value4)
	dev.print(string, value)
	dev.string2 = string2
	dev.value2 = value2
	dev.string3 = string3
	dev.value3 = value3
	dev.string4 = string4
	dev.value4 = value4
end

function dev.render()
	-- set the color to white
	love.graphics.setColor(255, 255, 255)
	love.graphics.print(dev.string .. dev.value, 0, 0)
	love.graphics.print(dev.string2 .. dev.value2, 0, 12)
	love.graphics.print(dev.string3 .. dev.value3, 0, 24)
	love.graphics.print(dev.string4 .. dev.value4, 0, 36)
end

return dev