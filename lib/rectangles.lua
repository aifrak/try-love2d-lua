local rectangle = require("rectangle")

local rectangles = {}
local tableRectangles = {}

function rectangles:load()
  local rect = rectangle:new()
  table.insert(tableRectangles, rect)

  return self
end

function rectangles:updateAll(dt)
  for _, rect in ipairs(tableRectangles) do
    rectangle:update(rect, dt)
  end

  return self
end

function rectangles:drawAll()
  for _, rect in ipairs(tableRectangles) do
    rectangle:draw(rect)
  end

  return self
end

function rectangles:createRectangle()
  local rect = rectangle:new()
  table.insert(tableRectangles, rect)

  return self
end

return rectangles
