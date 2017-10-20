local ParentTransformSyncer = class("parentTransformSyncer", System)

local function getFirstParentWithTransform(e)
   return e.parent:has("transform") and e.parent or getFirstParentWithTransform(e.parent)
end

function ParentTransformSyncer:update()
   for _, e in pairs(self.targets) do
      e:get("transform").parent = getFirstParentWithTransform(e):get("transform")
   end
end

function ParentTransformSyncer:requires()
   return {"transform"}
end

return ParentTransformSyncer
