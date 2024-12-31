local Player = require "mover.player"
local Wall = require "mover.wall"
local Box = require "mover.box"

local Mover = {}

local player
local wall
local box
local objects

function Mover:load()
  player = Player(100, 100)
  wall = Wall(200, 100)
  box = Box(400, 150)

  objects = {}
  table.insert(objects, player)
  table.insert(objects, wall)
  table.insert(objects, box)

  return self
end

function Mover:update(dt)
  -- Update all the objects
  for _, v in ipairs(objects) do
    v:update(dt)
  end

  -- Check collisions twice only once
  -- Go through all the objects (except the last)

  local loop = true
  local limit = 0

  while loop do
    -- Set loop to false, if no collision happened it will stay false
    loop = false

    limit = limit + 1
    if limit > 100 then
      -- Still not done at loop 100
      -- Break it because we're probably stuck in an endless loop.
      break
    end

    for i = 1, #objects - 1 do
      for j = i + 1, #objects do
        local collision = objects[i]:resolveCollision(objects[j])
        if collision then
          loop = true
        end
      end
    end
  end

  return self
end

function Mover:draw()
  -- Draw all the objects
  for _, v in ipairs(objects) do
    v:draw()
  end

  return self
end

return Mover
