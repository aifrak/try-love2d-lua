local Assets = require "assets"

function love.conf(t)
  t.window.title = "Testing Lua"
  t.window.icon = Assets.image_path("sheep.png")
end
