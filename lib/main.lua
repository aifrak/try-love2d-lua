local rectangles = require("rectangles")

function love.load()
  rectangles:load()
end

function love.update(dt)
  rectangles:updateAll(dt)
end

function love.draw()
  love.graphics.setColor(255, 255, 255)
  love.graphics.print("Hello World", 400, 300)

  rectangles:drawAll()
end

function love.keypressed(key)
  if key == "space" then
    rectangles:createRectangle()
  end
end
