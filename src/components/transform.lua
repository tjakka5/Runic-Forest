local Vector = require("lib.vector")

local Transform = Component.create("transform")

function Transform:initialize(position, rotation)
   self.position = position
   self.rotation = rotation

   self.parent = nil
end

function Transform:setPosition(position)
   self.position:set(position)
end

function Transform:setRotation(phi)
   self.rotation = phi
end

function Transform:getWorldPosition()
   if self.parent then
      local newPosition = self.position:rotated(self.parent.rotation)

      return newPosition + self.parent:getWorldPosition()
   end

   return self.position
end

function Transform:lookAt(other)
   self.rotation = self.position:angleTo(other.position)
end

function Transform:translate(delta)
   self.position = self.position + delta
end

function Transform:rotate(phi)
   self.rotation = self.rotation + phi
end
