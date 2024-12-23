local Rectangles = {}

local Rectangle = require "rectangle"

local tableRectangles = {}

function Rectangles:load()
  local rect = Rectangle:new()
  table.insert(tableRectangles, rect)

  return self
end

function Rectangles:createRectangle()
  local rect = Rectangle:new()
  table.insert(tableRectangles, rect)

  return self
end

function Rectangle:update(rect, dt)
  if love.keyboard.isDown("right") then
    rect.x = rect.x + 100 * dt
  elseif love.keyboard.isDown("left") then
    rect.x = rect.x - 100 * dt
  end

  return self
end

function Rectangles:updateAll(dt)
  for _, rect in ipairs(tableRectangles) do
    Rectangle:update(rect, dt)
  end

  return self
end

function Rectangle:draw(rect)
  love.graphics.setColor(love.math.colorFromBytes(0, 102, 102))
  love.graphics.rectangle(
    "fill",
    rect.x,
    rect.y,
    rect.width,
    rect.height
  )

  return self
end

function Rectangles:drawAll()
  for _, rect in ipairs(tableRectangles) do
    Rectangle:draw(rect)
  end

  return self
end

return Rectangles
