local Rectangles = require "rectangles"
local Tick = require "tick"

local drawRectangle = false

function love.load()
  Rectangles:load()

  --The first argument is a function
  --The second argument is the time it takes to call the function
  Tick.delay(function() drawRectangle = true end, 2)
end

function love.update(dt)
  Rectangles:updateAll(dt)
  Tick.update(dt)
end

function love.draw()
  love.graphics.setColor(255, 255, 255)
  love.graphics.print("Hello World", 400, 300)

  Rectangles:drawAll()

  --if drawRectangle is true then draw a rectangle
  if drawRectangle then
    love.graphics.setColor(255, 255, 255)
    love.graphics.rectangle("fill", 100, 100, 300, 200)
  end
end

function love.keypressed(key)
  if key == "space" then
    Rectangles:createRectangle()
  end
end
