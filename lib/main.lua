local rectangle = require("rectangle")

local rects = {}

function love.load()
  local rect = rectangle.createRectangle()
  table.insert(rects, rect)
end

function love.update(dt)
  for _, rect in ipairs(rects) do
    rectangle.update(rect, dt)
  end
end

function love.draw()
  love.graphics.setColor(255, 255, 255)
  love.graphics.print("Hello World", 400, 300)

  for _, rect in ipairs(rects) do
    rectangle.draw(rect)
  end
end

function love.keypressed(key)
  if key == "space" then
    local rect = rectangle.createRectangle()
    table.insert(rects, rect)
  end
end
