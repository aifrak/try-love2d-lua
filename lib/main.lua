-- Load some default values for our rectangle.
function love.load()
  X, Y, W, H = 20, 20, 60, 20
end

-- Increase the size of the rectangle every frame.
function love.update(dt)
  W = W + 1
  H = H + 1
end

function love.draw()
  love.graphics.print("Hello World", 400, 300)

  -- Draw a coloured rectangle.
  love.graphics.setColor(0, 0.4, 0.4)
  love.graphics.rectangle("fill", X, Y, W, H)
end
