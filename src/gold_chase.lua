local GoldChase = {}

local Assets = require "assets"
local Lume = require "vendors.lume.lume"

-- tables
local coins = {}

local player
local score
local shakeDuration
local shakeWait
local shakeOffset
local data = {
  x = nil,
  y = nil,
  size = nil,
  coins = {}
}

function GoldChase:new()
  score = 0
  player = {
    x = 100,
    y = 100,
    size = 25
  }

  return self
end

function GoldChase:load()
  score = 0
  shakeDuration = 0
  shakeWait = 0
  shakeOffset = { x = 0, y = 0 }
  player = {
    x = 100,
    y = 100,
    size = 25,
    image = love.graphics.newImage(Assets.players_path("face.png"))
  }

  if love.filesystem.getInfo("savedata.txt") then
    local file = love.filesystem.read("savedata.txt")
    data = Lume.deserialize(file)

    --Apply the player info
    player.x = data.player.x
    player.y = data.player.y
    player.size = data.player.size

    for i, v in ipairs(data.coins) do
      coins[i] = {
        x = v.x,
        y = v.y,
        size = 10,
        image = love.graphics.newImage(Assets.items_path("dollar.png"))
      }
    end
  else
    -- Only execute this if you don't have a save file
    for _ = 1, 25 do
      table.insert(coins,
        {
          x = love.math.random(50, 650),
          y = love.math.random(50, 450),
          size = 10,
          image = love.graphics.newImage(Assets.items_path("dollar.png"))
        }
      )
    end
  end

  return self
end

function GoldChase:update(dt)
  -- Make it moveable with keyboard
  if love.keyboard.isDown("left") then
    player.x = player.x - 200 * dt
  elseif love.keyboard.isDown("right") then
    player.x = player.x + 200 * dt
  end

  -- Note how I start a new if-statement instead of contuing the elseif
  -- I do this because else you wouldn't be able to move diagonally.
  if love.keyboard.isDown("up") then
    player.y = player.y - 200 * dt
  elseif love.keyboard.isDown("down") then
    player.y = player.y + 200 * dt
  end

  -- Start at the end, until 1, with steps of -1
  for i = #coins, 1, -1 do
    -- Use coins[i] instead of v
    if GoldChase.checkCollision(player, coins[i]) then
      table.remove(coins, i)
      player.size = player.size + 1
      score = score + 1
      shakeDuration = 0.3
    end
  end

  if shakeDuration > 0 then
    shakeDuration = shakeDuration - dt
    if shakeWait > 0 then
      shakeWait = shakeWait - dt
    else
      shakeOffset.x = love.math.random(-5, 5)
      shakeOffset.y = love.math.random(-5, 5)
      shakeWait = 0.05
    end
  end

  return self
end

function GoldChase:draw()
  love.graphics.push() -- Make a copy of the current state and push it onto the stack.
  -- Camera follows the player
  love.graphics.translate(-player.x + 400, -player.y + 300)

  if shakeDuration > 0 then
    -- This second translate will be done based on the previous translate.
    -- So it will not reset the previous translate.
    love.graphics.translate(shakeOffset.x, shakeOffset.y)
  end

  love.graphics.circle("line", player.x, player.y, player.size)
  love.graphics.draw(player.image, player.x, player.y,
    0, 1, 1, player.image:getWidth() / 2, player.image:getHeight() / 2)

  for _, v in ipairs(coins) do
    love.graphics.circle("line", v.x, v.y, v.size)
    love.graphics.draw(v.image, v.x, v.y,
      0, 1, 1, v.image:getWidth() / 2, v.image:getHeight() / 2)
  end

  -- Draw score top left of the screen
  love.graphics.pop() -- Pull the copy of the state of the stack and apply it.
  -- Alternative 1 way to draw score top left
  -- love.graphics.translate(player.x - 400, player.y - 300)
  -- Alternative 2 way to draw score top left
  -- love.graphics.origin()
  love.graphics.print(score, 10, 10)

  return self
end

function GoldChase.checkCollision(p1, p2)
  -- Calculating distance in 1 line
  -- Subtract the x's and y's, square the difference
  -- Sum the squares and find the root of the sum.
  local distance = math.sqrt((p1.x - p2.x) ^ 2 + (p1.y - p2.y) ^ 2)
  -- Return whether the distance is lower than the sum of the sizes.
  return distance < p1.size + p2.size
end

function GoldChase:saveGame()
  data.player = {
    x = player.x,
    y = player.y,
    size = player.size
  }

  data.coins = {}
  for i, v in ipairs(coins) do
    -- In this case data.coins[i] = value is the same as table.insert(data.coins, value )
    data.coins[i] = { x = v.x, y = v.y }
  end

  local serialized = Lume.serialize(data)
  -- The filetype actually doesn't matter, and can even be omitted.
  love.filesystem.write("savedata.txt", serialized)

  return self
end

function GoldChase:save_game_on_keypressed(key)
  if key == "f1" then
    self:saveGame()
  end

  return self
end

function GoldChase:restart_on_keypressed(key)
  if key == "f2" then
    love.filesystem.remove("savedata.txt")
    love.event.quit("restart")
  end

  return self
end

return GoldChase
