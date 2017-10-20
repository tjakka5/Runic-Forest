local Bump   = require("lib.bump")
local Vector = require("lib.vector")

local World   = Bump.newWorld(32)
local Gravity = 10

local AxisAlignedPhysics = class("axisAlignedPhysics", System)

function AxisAlignedPhysics:update(dt)
   for _, e in pairs(self.targets) do
      local transform       = e:get("transform")
      local axisAlignedBody = e:get("axisAlignedBody")

      axisAlignedBody:setPosition(transform.position)
      axisAlignedBody:applyFriction(dt)
      axisAlignedBody:applyGravity(Gravity, dt)
      axisAlignedBody:move(dt)

      transform:setPosition(axisAlignedBody)

      local x, y = transform:getWorldPosition():unpack()
      x, y = World:move(self, x, y, axisAlignedBody.filter)

      transform:setPosition(Vector(x, y))
   end
end

function AxisAlignedPhysics:onAddEntity(e)
   local transform       = e:get("transform")
   local axisAlignedBody = e:get("axisAlignedBody")

   local x, y = transform:getWorldPosition():unpack()
   local w, h = axisAlignedBody.dimensions:unpack()

   World:add(e, x, y, w, h)
end

function AxisAlignedPhysics:onRemoveEntity(e)
end

function AxisAlignedPhysics:requires()
   return {"transform", "axisAlignedBody"}
end

return AxisAlignedPhysics
