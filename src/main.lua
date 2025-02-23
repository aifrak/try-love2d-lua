package.path = "./src/lib/?/?.lua;"
    .. "./src/lib/?/init.lua;"
    .. "./src/lib/?.lua;"
    .. package.path

-- Debug: Hot Reloading
local Lick = require "lick"
Lick.debug = true
Lick.reset = true
Lick.showReloadMessage = true
Lick.clearPackages = true
Lick.entryPoint = "main.lua"
Lick.fileExtensions = { ".lua", ".ogg", ".png" }

local Inspect = require "inspect"
local Assets = require "assets"
local Rectangles = require "rectangles"
local Tick = require "tick"
local Jump = require "jump"
local Maze = require "maze"
local GoldChase = require "gold_chase"
local Mover = require "mover"

local draw_rectangle = false
local myImage
local song
local sfx

local jump

print(Inspect("test"))


---@diagnostic disable-next-line: duplicate-set-field
function love.load()
  song = love.audio.newSource(Assets.music_path("song.ogg"), "stream")
  song:setLooping(true)
  song:play()

  sfx = love.audio.newSource(Assets.sfx_path("sfx.ogg"),
    "static")

  myImage = love.graphics.newImage(Assets.image_path("sheep.png"))

  love.graphics.setBackgroundColor(love.math.colorFromBytes(181, 121, 121))

  Rectangles:load()

  --The first argument is a function
  --The second argument is the time it takes to call the function
  Tick.delay(function() draw_rectangle = true end, 2)

  jump = Jump.new()
  Jump:load()

  Maze:load()

  GoldChase:load()

  Mover:load()
end

---@diagnostic disable-next-line: duplicate-set-field
function love.update(dt)
  Rectangles:updateAll(dt)
  Tick.update(dt)
  Jump:update(jump, dt)
  GoldChase:update(dt)
  Mover:update(dt)
end

---@diagnostic disable-next-line: duplicate-set-field
function love.draw()
  love.graphics.setColor(love.math.colorFromBytes(255, 200, 40, 127))
  love.graphics.draw(myImage, 100, 100, 45, -1, -1, 39, 50)

  love.graphics.setColor(love.math.colorFromBytes(255, 255, 255))
  love.graphics.print("Hello World", 400, 300, 25, 3, 3)

  Rectangles:drawAll()
  Jump:draw(jump)

  --if drawRectangle is true then draw a rectangle
  if draw_rectangle then
    love.graphics.setColor(love.math.colorFromBytes(255, 255, 255))
    love.graphics.rectangle("fill", 300, 300, 50, 50)
  end

  Maze:draw()
  GoldChase:draw()
  Mover:draw()
end

function love.keypressed(key)
  if key == "space" then
    Rectangles:createRectangle()
    sfx:play()
  end

  Maze:move_player_on_keypressed(key)

  GoldChase:save_game_on_keypressed(key)
  GoldChase:restart_on_keypressed(key)

  Mover.control_player_on_keypressed(key)
end
