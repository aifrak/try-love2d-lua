local x, y, w, h

-- Load some default values for our rectangle.
function love.load()
  x, y, w, h = 20, 20, 60, 20
end

-- Increase the size of the rectangle every frame.
function love.update(dt)
  w = w + 1
  h = h + 1
end

function love.draw()
  love.graphics.print("Hello World", 400, 300)

  -- Draw a coloured rectangle.
  love.graphics.setColor(0, 0.4, 0.4)
  love.graphics.rectangle("fill", x, y, w, h)
end
