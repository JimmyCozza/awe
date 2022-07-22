local awful = require "awful"
local beautiful = require "beautiful"
require "ui.colors"
local theme = require "ui.theme"
local bar = require("ui.bar." .. User_vars.bar_ui)
local utils = require "utils"
beautiful.init(theme)

-- Set background
awful.spawn.with_shell("feh --bg-fill --randomize ~/Pictures/wallpapers/" .. User_vars.colorscheme)

awful.screen.connect_for_each_screen(function(s)
  -- set layouts
  awful.layout.layouts = User_vars.layouts
  awful.tag({ " ", " ", "聆 ", " ", "阮 " }, s, User_vars.layouts[1])
  -- Setup any utility functions I need
  utils.logout(s)
  -- set that bar
  bar(s)
end)
