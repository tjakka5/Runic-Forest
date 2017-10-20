local DeveloperBuild = false

local Settings = require("src.settings")
Settings.load()
Settings.apply()

-- Libraries
local HooEcs = require("lib.hooecs")
HooEcs.initialize({
   debug   = true,
   globals = true,
})

local Vector = require("lib.vector")

-- Components
require("src.components.transform")
require("src.components.axisAlignedBody")

local Transform       = Component.load({"transform"})
local AxisAlignedBody = Component.load({"axisAlignedBody"})

-- Events
require("src.events.keyPressed")
require("src.events.keyReleased")
require("src.events.mousePressed")
require("src.events.mouseReleased")
require("src.events.mouseMoved")
require("src.events.wheelMoved")

local KeyPressed    = Component.load({"keyPressed"})
local KeyReleased   = Component.load({"keyReleased"})
local MousePressed  = Component.load({"mousePressed"})
local MouseReleased = Component.load({"mouseReleased"})
local MouseMoved    = Component.load({"mouseMoved"})
local WheelMoved    = Component.load({"wheelMoved"})

-- Systems
local ParentTransformSyncer = require("src.systems.parentTransformSyncer")()
local DebugRenderer         = require("src.systems.debugRenderer")()
local AxisAlignedPhysics    = require("src.systems.axisAlignedPhysics")()

-- Engines
local GameEngine = require("src.engines.gameEngine")

local Dev = DeveloperBuild and require("dev")

function love.load()
   love.graphics.setBackgroundColor(225, 225, 225)

   if Dev then Dev.load() end

   myEntity = Entity()
   local x = love.graphics.getWidth()  / 2
   local y = love.graphics.getHeight() / 2
   myEntity:add(Transform(Vector(x, y), 0))
   myEntity:add(AxisAlignedBody(Vector(0, 0), Vector(50, 50), 0, 1, nil))

   GameEngine:addEntity(myEntity)

   GameEngine:addSystem(ParentTransformSyncer)
   GameEngine:addSystem(DebugRenderer)
   GameEngine:addSystem(AxisAlignedPhysics)
end

function love.update(dt)
   GameEngine:update(dt)

   if Dev then Dev.update(dt) end
end

function love.draw()
   GameEngine:draw()

   if Dev then Dev.draw() end
end

function love.quit()
   if Dev then Dev.quit() end
end

function love.textinput(t)
   if Dev then Dev.textinput(t) end

   if not (Dev and Dev.wantsCaptureMouse()) then

   end
end

function love.keypressed(key, scancode)
   if Dev then Dev.keypressed(key) end

   if not (Dev and Dev.wantsCaptureMouse()) then
      GameEngine.eventManager:fireEvent(KeyPressed(key, scancode, isRepeat))

      if key == "q" and love.keyboard.isDown("lctrl") then
         love.event.quit()
      end
   end
end

function love.keyreleased(key, scancode)
   if Dev then Dev.keyreleased(key, scancode) end

   if not (Dev and Dev.wantsCaptureMouse()) then
      GameEngine.eventManager:fireEvent(KeyReleased(key, scancode, isRepeat))
   end
end

function love.mousepressed(x, y, button)
   if Dev then Dev.mousepressed(x, y, button) end

   if not (Dev and Dev.wantsCaptureMouse()) then
      GameEngine.eventManager:fireEvent(MousePressed(x, y, button))
   end
end

function love.mousereleased(x, y, button)
   if Dev then Dev.mousereleased(x, y, button) end

   if not (Dev and Dev.wantsCaptureMouse()) then
      GameEngine.eventManager:fireEvent(MouseReleased(x, y, button))
   end
end

function love.mousemoved(dx, dy)
   if Dev then Dev.mousemoved(dx, dy) end

   if not (Dev and Dev.wantsCaptureMouse()) then
      GameEngine.eventManager:fireEvent(MouseMoved(dx, dy))
   end
end

function love.wheelmoved(dx, dy)
   if Dev then Dev.wheelmoved(dx, dy) end

   if not (Dev and Dev.wantsCaptureMouse()) then
      GameEngine.eventManager:fireEvent(WheelMoved(dx, dy))
   end
end
