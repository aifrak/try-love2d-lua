local Rectangles = require "rectangles"
local Tick = require "tick"

local drawRectangle = false
local myImage

function love.load()
  myImage = love.graphics.newImage("assets/images/sheep.png")

  love.graphics.setBackgroundColor(love.math.colorFromBytes(181, 121, 121))

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
  love.graphics.setColor(love.math.colorFromBytes(255, 200, 40, 127))
  love.graphics.draw(myImage, 100, 100, 45, -1, -1, 39, 50)

  love.graphics.setColor(love.math.colorFromBytes(255, 255, 255))
  love.graphics.print("Hello World", 400, 300, 25, 3, 3)

  Rectangles:drawAll()

  --if drawRectangle is true then draw a rectangle
  if drawRectangle then
    love.graphics.setColor(love.math.colorFromBytes(255, 255, 255))
    love.graphics.rectangle("fill", 100, 100, 300, 200)
  end
end

function love.keypressed(key)
  if key == "space" then
    Rectangles:createRectangle()
  end
end
