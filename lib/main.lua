local rectangle = require("rectangle")

local rect

function love.load()
  rect = rectangle.createRectangle()
end

function love.update(dt)
  rectangle.update(rect, dt)
end

function love.draw()
  love.graphics.setColor(255, 255, 255)
  love.graphics.print("Hello World", 400, 300)

  -- Draw a coloured rectangle.
  rectangle.draw(rect)
end
