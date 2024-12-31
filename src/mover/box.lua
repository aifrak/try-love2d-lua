local Entity = require "mover.entity"
local Box = Entity:extend()

function Box:new(x, y)
  Box.super.new(self, x, y, "sprites/items/box.png")
end

return Box
