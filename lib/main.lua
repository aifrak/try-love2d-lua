local rectangles = require "rectangles"
local tick = require "tick"

local drawRectangle = false

function love.load()
  rectangles:load()

  --The first argument is a function
  --The second argument is the time it takes to call the function
  tick.delay(function() drawRectangle = true end, 2)
end

function love.update(dt)
  rectangles:updateAll(dt)
  tick.update(dt)
end

function love.draw()
  love.graphics.setColor(255, 255, 255)
  love.graphics.print("Hello World", 400, 300)

  rectangles:drawAll()

  --if drawRectangle is true then draw a rectangle
  if drawRectangle then
    love.graphics.setColor(255, 255, 255)
    love.graphics.rectangle("fill", 100, 100, 300, 200)
  end
end

function love.keypressed(key)
  if key == "space" then
    rectangles:createRectangle()
  end
end
