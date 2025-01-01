local Player = require "mover.player"
local Wall = require "mover.wall"
local Box = require "mover.box"

local Mover = {}

-- tables
local walls
local objects

local player
local box
local map

function Mover:load()
  player = Player(100, 100)
  box = Box(400, 150)

  objects = {}
  table.insert(objects, player)
  table.insert(objects, box)

  walls = {}

  map = {
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
    { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
    { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
    { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
    { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
    { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
    { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1 },
    { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1 },
    { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1 },
    { 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
    { 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 }
  }

  -- Add walls according to the map
  for i, v in ipairs(map) do
    for j, w in ipairs(v) do
      if w == 1 then
        -- Add all the walls to the walls table instead.
        table.insert(walls, Wall((j - 1) * 50, (i - 1) * 50))
      end
    end
  end

  return self
end

function Mover:update(dt)
  -- Update all the objects
  for _, v in ipairs(objects) do
    v:update(dt)
  end

  for _, v in ipairs(walls) do
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

    -- For each object check collision with every wall.
    for _, wall in ipairs(walls) do
      for _, object in ipairs(objects) do
        local collision = object:resolveCollision(wall)
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

  -- Draw the walls
  for _, v in ipairs(walls) do
    v:draw()
  end

  return self
end

function Mover.control_player_on_keypressed(key)
  if key == "up" then
    player:jump()
  end
end

return Mover
