local gears = require "gears"
local awful = require "awful"
awful.spawn "xrdb ~/dotfiles/.xfiles/gruvbox"

require "config.globalvars"
require "config.rules"
--require "signals"
require "ui"
require "config.keybindings"
--require "noscope"

-- Shell applications
awful.spawn.with_shell "~/.config/awesome/autostart.sh"

-- Garbage Collector Settings
collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)
gears.timer {
  timeout = 5,
  autostart = true,
  call_now = true,
  callback = function()
    collectgarbage "collect"
  end,
}
