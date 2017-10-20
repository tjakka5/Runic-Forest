function love.conf(t)
  t.identity = "Runic Forest Dev"
  t.version  = "0.10.2"
  t.console  = true

  t.gammacorrect = true

  t.accelerometerjoystick = false
  t.externalstorage       = false

  t.window = nil

  t.modules.audio    = true
  t.modules.event    = true
  t.modules.graphics = true
  t.modules.image    = true
  t.modules.joystick = true
  t.modules.keyboard = true
  t.modules.math     = true
  t.modules.mouse    = true
  t.modules.physics  = true
  t.modules.sound    = true
  t.modules.system   = true
  t.modules.timer    = true
  t.modules.touch    = false
  t.modules.video    = false
  t.modules.window   = true
  t.modules.thread   = false
end
