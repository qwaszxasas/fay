local Entity = require.relative(..., 'Entity')

local Being = class('Being', Entity)

local DEFAULT_W = 16
local DEFAULT_H = 16
local DEFAULT_SPEED = 60

local sqrt = math.sqrt

local function abs(x) return x < 0 and -x or x end
local function vectorLength(x,y) return sqrt(x*x + y*y) end
local function truncateVector(maxL, x,y)
  if x==0 and y==0 then return 0,0 end
  local s = maxL / vectorLength(x,y)
  s = s > 1 and s or 1
  return x*s, y*s
end

function Being:initialize(x,y,w,h,speed)
  w,h = w or DEFAULT_W, h or DEFAULT_H
  Entity.initialize(self, x-w/2, y-w/2, w, h)
  self.speed = speed or DEFAULT_SPEED
end

function Being:shouldCollide()
  return true
end

function Being:collision(other, dx, dy)
  self.l, self.t = self.l + dx, self.t + dy
end

function Being:getDesiredMovementVector()
  return 0,0 -- no movement
end

function Being:isOpaque()
  return false
end

function Being:draw()
  love.graphics.setColor(0,255,0)
  local cx,cy = self:getCenter()
  love.graphics.circle('line', cx,cy, self.w/2)
end

function Being:update(dt)
  local dx, dy = truncateVector(self.speed, self:getDesiredMovementVector())
  self.l, self.t = self.l + dx*dt, self.t + dy*dt
end

return Being


