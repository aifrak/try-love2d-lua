local rectangle = {
  x = 150,
  y = 150,
  height = 300,
  width = 300
}

function rectangle.update(dt)
  if love.keyboard.isDown("right") then
    rectangle.x = rectangle.x + 100 * dt
  elseif love.keyboard.isDown("left") then
    rectangle.x = rectangle.x - 100 * dt
  end
end

function rectangle.draw()
  love.graphics.setColor(0, 0.4, 0.4)
  love.graphics.rectangle(
    "fill",
    rectangle.x,
    rectangle.y,
    rectangle.width,
    rectangle.height
  )
end

return rectangle
