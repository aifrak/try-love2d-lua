local Entity = require "mover.entity"

local Wall = Entity:extend()

function Wall:new(x, y)
  Wall.super.new(self, x, y, "maps/wall.png", 1)

  self.strength = 100
  self.weight = 0

  return self
end

return Wall
