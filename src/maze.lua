local Assets = require "assets"

local Maze = {}

-- tables
local quads = {}

local tilemap
local image
local width
local height
local player

function Maze:load()
  image = love.graphics.newImage(Assets.maps_path("tileset.png"))

  --We need the full image width and height for creating the quads
  local image_width = image:getWidth()
  local image_height = image:getHeight()

  --The width and height of each tile is 32, 32
  --So we could do:
  width = 32
  height = 32

  --But let's say we don't know the width and height of a tile
  --We can also use the number of rows and columns in the tileset
  --Our tileset has 2 rows and 3 columns
  --But we need to subtract 2 to make up for the empty pixels we included to prevent bleeding
  width = (image_width / 3) - 2
  height = (image_height / 2) - 2

  for i = 0, 1 do
    for j = 0, 2 do
      --The only reason this code is split up in multiple lines
      --is so that it fits the page
      table.insert(quads,
        love.graphics.newQuad(
          1 + j * (width + 2),
          1 + i * (height + 2),
          width, height,
          image_width, image_height))
    end
  end

  tilemap = {
    { 1, 6, 6, 2, 1, 6, 6, 2 },
    { 3, 0, 0, 4, 5, 0, 0, 3 },
    { 3, 0, 0, 0, 0, 0, 0, 3 },
    { 4, 2, 0, 0, 0, 0, 1, 5 },
    { 1, 5, 0, 0, 0, 0, 4, 2 },
    { 3, 0, 0, 0, 0, 0, 0, 3 },
    { 3, 0, 0, 1, 2, 0, 0, 3 },
    { 4, 6, 6, 5, 4, 6, 6, 5 }
  }

  --Create our player
  player = {
    image = love.graphics.newImage(Assets.players_path("player.png")),
    tile_x = 2,
    tile_y = 2
  }

  return self
end

function Maze:draw()
  for i, row in ipairs(tilemap) do
    for j, tile in ipairs(row) do
      if tile ~= 0 then
        love.graphics.draw(image, quads[tile], j * width, i * height)
      end
    end
  end

  --Draw the player and multiple its tile position with the tile width and height
  love.graphics.draw(player.image, player.tile_x * width, player.tile_y * height)

  return self
end

function Maze:move_player_on_keypressed(key)
  local x = player.tile_x
  local y = player.tile_y

  if key == "left" then
    x = x - 1
  elseif key == "right" then
    x = x + 1
  elseif key == "up" then
    y = y - 1
  elseif key == "down" then
    y = y + 1
  end

  if Maze:isEmpty(x, y) then
    player.tile_x = x
    player.tile_y = y
  end

  return self
end

function Maze:isEmpty(x, y)
  return tilemap[y][x] == 0
end

return Maze
