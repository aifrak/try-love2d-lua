local Object = require "vendors.classic.classic"
local Assets = require "assets"

local Entity = Object:extend()

function Entity:new(x, y, image_path)
  self.x = x
  self.y = y
  self.image = love.graphics.newImage(Assets.image_path(image_path))
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()

  self.last = {}
  self.last.x = self.x
  self.last.y = self.y

  -- It is like weight between 2 objects. If a player moves an item with more
  -- strength, the player will be blocked.
  self.strength = 0
  self.tempStrength = 0

  -- Add the gravity and weight properties
  self.gravity = 0
  self.weight = 400
end

function Entity:update(dt)
  -- Set the current position to be the previous position
  self.last.x = self.x
  self.last.y = self.y

  self.tempStrength = self.strength

  -- Increase the gravity using the weight
  self.gravity = self.gravity + self.weight * dt

  -- Increase the y-position
  self.y = self.y + self.gravity * dt

  return self
end

function Entity:wasVerticallyAligned(e)
  -- It's basically the collisionCheck function, but with the x and width part removed.
  -- It uses last.y because we want to know this from the previous position
  return self.last.y < e.last.y + e.height and
      self.last.y + self.height > e.last.y
end

function Entity:wasHorizontallyAligned(e)
  -- It's basically the collisionCheck function, but with the y and height part removed.
  -- It uses last.x because we want to know this from the previous position
  return self.last.x < e.last.x + e.width and self.last.x + self.width > e.last
      .x
end

function Entity:resolveCollision(e)
  if self.tempStrength > e.tempStrength then
    return e:resolveCollision(self)
  end

  if self:checkCollision(e) then
    self.tempStrength = e.tempStrength
    if self:wasVerticallyAligned(e) then
      if self.x + self.width / 2 < e.x + e.width / 2 then
        -- pusback = the right side of the player - the left side of the wall
        local pushback = self.x + self.width - e.x
        self.x = self.x - pushback
      else
        -- pusback = the right side of the wall - the left side of the player
        local pushback = e.x + e.width - self.x
        self.x = self.x + pushback
      end
    elseif self:wasHorizontallyAligned(e) then
      if self.y + self.height / 2 < e.y + e.height / 2 then
        -- pusback = the bottom side of the player - the top side of the wall
        local pushback = self.y + self.height - e.y
        self.y = self.y - pushback
        -- We're touching a wall from the bottom
        -- This means we're standing on the ground.
        -- Reset the gravity
        self.gravity = 0
      else
        -- pusback = the bottom side of the wall - the top side of the player
        local pushback = e.y + e.height - self.y
        self.y = self.y + pushback
      end
    end

    -- There was collision! After we've resolved the collision return true
    return true
  end

  -- There was NO collision, return false
  -- (Though not returning anything would've been fine as well)
  -- (Since returning nothing would result in the returned value being nil)
  return false
end

function Entity:draw()
  love.graphics.draw(self.image, self.x, self.y)
end

function Entity:checkCollision(e)
  -- e will be the other entity with which we check if there is collision.
  -- This is the final compact version from chapter 13
  return self.x + self.width > e.x
      and self.x < e.x + e.width
      and self.y + self.height > e.y
      and self.y < e.y + e.height
end

return Entity
