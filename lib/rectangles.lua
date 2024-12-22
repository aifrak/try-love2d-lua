local rectangle = require("rectangle")

local rectangles = {}
local tableRectangles = {}

function rectangles:load()
  local rect = rectangle:new()
  table.insert(tableRectangles, rect)

  return self
end

function rectangles:createRectangle()
  local rect = rectangle:new()
  table.insert(tableRectangles, rect)

  return self
end

function rectangle:update(rect, dt)
  if love.keyboard.isDown("right") then
    rect.x = rect.x + 100 * dt
  elseif love.keyboard.isDown("left") then
    rect.x = rect.x - 100 * dt
  end

  return self
end

function rectangles:updateAll(dt)
  for _, rect in ipairs(tableRectangles) do
    rectangle:update(rect, dt)
  end

  return self
end

function rectangle:draw(rect)
  love.graphics.setColor(0, 0.4, 0.4)
  love.graphics.rectangle(
    "fill",
    rect.x,
    rect.y,
    rect.width,
    rect.height
  )

  return self
end

function rectangles:drawAll()
  for _, rect in ipairs(tableRectangles) do
    rectangle:draw(rect)
  end

  return self
end

return rectangles
