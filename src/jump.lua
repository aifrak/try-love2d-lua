local Assets = require "assets"

local Jump = {}

local frames = {}

function Jump.new()
  local jump = {}
  jump.currentFrame = 1

  return jump
end

function Jump:load()
  for i = 1, 5 do
    table.insert(frames,
      love.graphics.newImage(Assets.image_path("jump" .. i .. ".png")))
  end

  return self
end

function Jump:update(jump, dt)
  jump.currentFrame = jump.currentFrame + 10 * dt

  if jump.currentFrame >= 6 then
    jump.currentFrame = 1
  end

  return self
end

function Jump:draw(jump)
  -- This is because our variable currentFrame has decimals.
  -- After the first update currentFrame is something like 1.016,
  -- and while our table has something on position 1 and 2,
  -- there is nothing on position 1.016.

  -- To solve this we round the number down with math.floor. So 1.016 will
  -- become 1.
  love.graphics.setColor(love.math.colorFromBytes(255, 255, 255))
  love.graphics.draw(frames[math.floor(jump.currentFrame)])

  return self
end

return Jump
