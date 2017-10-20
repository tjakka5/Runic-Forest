local AxisAlignedBodyRenderer = class("axisAlignedBodyRenderer", System)

function AxisAlignedBodyRenderer:draw()
   love.graphics.setColor(0, 0, 255)

   for _, e in pairs(self.targets) do
      local transform       = e:get("transform")
      local axisAlignedBody = e:get("axisAlignedBody")

      local x, y = transform:getWorldPosition():unpack()
      local w, h = axisAlignedBody.dimensions:unpack()

      love.graphics.rectangle("line", x - w/2, y - h/2, w, h)
   end
end

function AxisAlignedBodyRenderer:requires()
   return {"transform", "axisAlignedBody"}
end

return AxisAlignedBodyRenderer
