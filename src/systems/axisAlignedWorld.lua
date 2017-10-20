local Bump   = require("lib.bump")
local Vector = require("lib.vector")

local AxisAlignedWorld = class("axisAlignedWorld", System)
AxisAlignedWorld.world   = Bump.newWorld(32)
AxisAlignedWorld.gravity = Vector(0, 1000)

function AxisAlignedWorld:update(dt)
   for _, e in pairs(self.targets) do
      local transform       = e:get("transform")
      local axisAlignedBody = e:get("axisAlignedBody")

      axisAlignedBody.position:set(transform.position)
      axisAlignedBody:applyFriction(dt)
      axisAlignedBody:applyGravity(self.gravity, dt)
      axisAlignedBody:move(dt)

      transform.position:set(axisAlignedBody.position)

      local x, y = transform:getWorldPosition():unpack()
      local w, h = axisAlignedBody.dimensions:unpack()

      local newX, newY, colls, len = self.world:move(e, x - w/2, y - h/2, axisAlignedBody.filter)
      newX, newY = newX + w/2, newY + h/2

      for i = 1, len do
         local col = colls[i]

         if col.normal.y == -1 then
            axisAlignedBody.velocity.y = 0
         end
      end

      transform.position:set(newX, newY)
   end
end

function AxisAlignedWorld:onAddEntity(e)
   local transform       = e:get("transform")
   local axisAlignedBody = e:get("axisAlignedBody")

   local x, y = transform:getWorldPosition():unpack()
   local w, h = axisAlignedBody.dimensions:unpack()

   self.world:add(e, x - w/2, y - h/2, w, h)
end

function AxisAlignedWorld:onRemoveEntity(e)
   self.world:remove(e)
end

function AxisAlignedWorld:requires()
   return {"transform", "axisAlignedBody"}
end

return AxisAlignedWorld
