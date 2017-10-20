local DebugRenderer = class("debugRenderer", System)

function DebugRenderer:draw()
   love.graphics.setColor(255, 0, 0)

   for _, e in pairs(self.targets) do
      local transform = e:get("transform")

      local x, y = transform:getWorldPosition():unpack()

      love.graphics.rectangle("line", x - 5, y - 5, 10, 10)
      love.graphics.print(e.id, x - 10, y - 10)

      love.graphics.print(transform.rotation, 10, 10)
   end
end

function DebugRenderer:requires()
   return {"transform"}
end

return DebugRenderer
