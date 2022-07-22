local color = require "ui.colors"
local dpi = require("beautiful.xresources").apply_dpi
local gears = require "gears"
local awful = require "awful"
local icons = awful.util.getdir "config" .. "icons/"

local theme = {}

theme.font = User_vars.font.bold

theme.bg_normal = color["Grey900"]
theme.bg_focus = color["Grey900"]
theme.bg_urgent = color["RedA200"]
theme.bg_minimize = color["White"]
theme.bg_systray = color["White"]

theme.fg_normal = color["White"]
theme.fg_focus = color["White"]
theme.fg_urgent = color["White"]
theme.fg_minimize = color["White"]

theme.useless_gap = dpi(10)
theme.border_width = dpi(0)
theme.border_normal = color["Grey800"]
theme.border_marked = color["Red400"]

theme.menu_height = dpi(40)
theme.menu_width = dpi(200)
theme.menu_bg_normal = color["Grey900"]
theme.menu_bg_focus = color["Grey800"]
theme.menu_fg_focus = color["White"]
theme.menu_border_color = color["Grey800"]
theme.menu_border_width = dpi(0)
theme.menu_shape = function(cr, width, heigth)
  gears.shape.rectangle(cr, width, heigth)
end

theme.taglist_fg_focus = color.orange
theme.taglist_bg_focus = color.bg
theme.taglist_font = "JetBrains Mono Nerd Font, 30"

theme.tooltip_border_color = color["Grey900"]
theme.tooltip_bg = color["Grey800"]
theme.tooltip_fg = color["White"]
theme.tooltip_border_width = dpi(0)
theme.tooltip_shape = function(cr, width, heigth)
  gears.shape.rectangle(cr, width, heigth)
end

theme.notification_bg = color["Grey900"]
theme.notification_fg = color["White"]
theme.notification_border_width = dpi(0)
theme.notification_border_color = color["Grey900"]
theme.notification_shape = function(cr, width, heigth)
  gears.shape.rectangle(cr, width, heigth)
end
theme.notification_margin = dpi(10)
theme.notification_max_width = dpi(400)
theme.notification_max_height = dpi(1000)
theme.notification_icon_size = dpi(40)

theme.bg_systray = color.grey2
theme.systray_icon_spacing = dpi(10)

theme.hotkeys_bg = color["Grey900"]
theme.hotkeys_fg = color["White"]
theme.hotkeys_border_width = 0
theme.hotkeys_shape = function(cr, width, height)
  gears.shape.rectangle(cr, width, height)
end
theme.hotkeys_description_font = User_vars.font.bold

theme.layout_floating = gears.color.recolor_image(icons .. "/layout/floating.svg", color["Grey900"])
theme.layout_tile = gears.color.recolor_image(icons .. "/layout/tile.svg", color["Grey900"])

return theme
