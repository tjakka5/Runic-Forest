local Vector = require("lib.vector")

local Transform = Component.load({"transform"})

local GameEngine = Engine()

local RootEntity = GameEngine:getRootEntity()
RootEntity:add(Transform(Vector(0, 0), 0))

return GameEngine
