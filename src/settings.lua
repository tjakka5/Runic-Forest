local Bitser = require("lib.bitser")
local Enum   = require("src.util.enum")

local Settings = {
   fileName = "settings",

   data = {
      window = {
         width  = 1280,
         height = 720,

         flags = {
            vsync          = false,
            fullscreen     = false,
            fullscreentype = "exclusive",
            borderless     = false,
            display        = 1,
         }
      }
   },

   displayModes = Enum({
      "Windowed",
      "Fullscreen",
      "Borderless Windowed",
   }),

   resolutions = {
      {1024,  768},
      {1280,  720},
      {1280,  768},
      {1280,  800},
      {1280, 1024},
      {1360,  768},
      {1366,  786},
      {1440,  900},
      {1536,  864},
      {1600,  900},
      {1680, 1050},
      {1920, 1080},
      {1920, 1200},
      {2560, 1080},
      {2560, 1440},
      {3440, 1440},
      {3840, 2160},
   },
}

function Settings.setResolution(width, height)
   Settings.data.window.width  = width
   Settings.data.window.height = height
end

function Settings.setDisplayMode(displayMode)
   if displayMode == Settings.displayModes["Windowed"] then
      Settings.data.window.flags.fullscreen = false
      Settings.data.window.flags.borderless = false
   elseif displayMode == Settings.displayModes["Fullscreen"] then
      Settings.data.window.flags.fullscreen     = true
      Settings.data.window.flags.fullscreentype = "exclusive"
   elseif displayMode == Settings.displayModes["Borderless Windowed"] then
      Settings.data.window.flags.fullscreen     = true
      Settings.data.window.flags.fullscreentype = "desktop"
   end
end

function Settings.load()
   if love.filesystem.exists(Settings.fileName) then
      Settings.data = Bitser.loadLoveFile(Settings.fileName)
   else
      Settings.save()
   end
end

function Settings.save()
   Bitser.dumpLoveFile(Settings.fileName, Settings.data)
end

function Settings.apply()
   love.window.setMode(Settings.data.window.width, Settings.data.window.height, Settings.data.window.flags)
end

return Settings
