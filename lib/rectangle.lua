local rectangle = {}

function rectangle.createRectangle()
  local rect = {}
  rect.x = 150
  rect.y = 150
  rect.width = 300
  rect.height = 300

  return rect
end

function rectangle.update(rect, dt)
  if love.keyboard.isDown("right") then
    rect.x = rect.x + 100 * dt
  elseif love.keyboard.isDown("left") then
    rect.x = rect.x - 100 * dt
  end
end

function rectangle.draw(rect)
  love.graphics.setColor(0, 0.4, 0.4)
  love.graphics.rectangle(
    "fill",
    rect.x,
    rect.y,
    rect.width,
    rect.height
  )
end

return rectangle
