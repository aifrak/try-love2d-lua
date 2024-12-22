function love.load()

end

function love.update(dt)
  local rectangle = require("rectangle")
  rectangle.update(dt)
end

function love.draw()
  love.graphics.setColor(255, 255, 255)
  love.graphics.print("Hello World", 400, 300)

  -- Draw a coloured rectangle.
  local rectangle = require("rectangle")
  rectangle.draw()
end
