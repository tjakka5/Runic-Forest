Component.create("keyReleased").initialize = function(e, key, scancode, isRepeat)
   e.key      = key
   e.scancode = scancode
   e.isRepeat = isRepeat
end
