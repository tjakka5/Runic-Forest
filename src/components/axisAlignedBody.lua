local AxisAlignedBody = Component.create("axisAlignedBody")

function AxisAlignedBody:initialize(position, velocity, dimensions, friction, gravityScale)
   self.position   = position
   self.velocity   = velocity
   self.dimensions = dimensions

   self.friction     = friction
   self.gravityScale = gravityScale
end

function AxisAlignedBody:applyForce(force)
   self.velocity:add(force)
end

function AxisAlignedBody:applyGravity(gravity, dt)
   self:applyForce(gravity * self.gravityScale * dt)
end

function AxisAlignedBody:applyFriction(dt)
   local friction = self.velocity:clone()

   friction:mul(-1)
   friction:normalizeInplace()
   friction:mul(self.friction)

   self:applyForce(friction * dt)
end

function AxisAlignedBody:move(dt)
   self.position:add(self.velocity * dt)
end
