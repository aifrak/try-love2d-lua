local Entity = require "mover.entity"

local Wall = Entity:extend()

function Wall:new(x, y)
  Wall.super.new(self, x, y, "maps/wall.png")

  self.strength = 100

  return self
end

return Wall
