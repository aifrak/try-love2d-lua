local Assets = require "assets"

local Jump = {}

local frames = {}
local image

function Jump.new()
  local jump = {}
  jump.currentFrame = 1

  return jump
end

function Jump:load()
  image = love.graphics.newImage(Assets.image_path("jump_3.png"))

  local width = image:getWidth()
  local height = image:getHeight()

  local frame_width = 117
  local frame_height = 233

  local maxFrames = 5

  -- Next 2 arguments are the width and height of our quad.
  -- The width of a frame in our image is 117 and the height is 233.
  -- The last 2 arguments are the width and height of the full image

  -- And now our quads are in the correct position. Here's an image visualizing
  -- how we position the quad. So we add 1, then add frame_width + 2, multiplied
  -- by i.
  -- This way we position the quad correctly for each frame.
  for i = 0, 2 do
    for j = 0, 2 do
      table.insert(frames,
        love.graphics.newQuad(1 + j * (frame_width + 2),
          1 + i * (frame_height + 2),
          frame_width,
          frame_height, width,
          height))
      if #frames == maxFrames then
        break
      end
    end
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
  love.graphics.draw(image, frames[math.floor(jump.currentFrame)], 100, 100)

  return self
end

return Jump
