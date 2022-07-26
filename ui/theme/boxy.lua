local color = require "ui.colors"
local dpi = require("beautiful.xresources").apply_dpi
local gears = require "gears"
local awful = require "awful"
local icons = awful.util.getdir "config" .. "icons/"

local theme = {}

theme.font = User_vars.font.bold

theme.bg_normal = color.bg
theme.bg_focus = color.pane_2
theme.bg_urgent = color.error
theme.bg_minimize = color.fg
theme.bg_systray = color.surface

theme.fg_normal = color.fg
theme.fg_focus = color.fg
theme.fg_urgent = color.link_url
theme.fg_minimize = color.fg

theme.useless_gap = dpi(10)
theme.border_width = dpi(0)
theme.border_radius = dpi(5)
theme.border_normal = color.border_inactive
theme.border_focus = color.border_active
theme.border_marked = color.border_active

theme.menu_height = dpi(40)
theme.menu_width = dpi(200)
theme.menu_bg_normal = color.pane
theme.menu_bg_focus = color.pane_2
theme.menu_fg_focus = color.subtext
theme.menu_border_color = color.border_inactive
theme.menu_border_width = dpi(0)
theme.menu_shape = function(cr, width, height)
  gears.shape.rectangle(cr, width, height)
end

theme.taglist_fg_focus = color.warning
theme.taglist_bg_focus = color.bg
theme.taglist_font = "JetBrains Mono Nerd Font, 30"

theme.tooltip_border_color = color.border_active
theme.tooltip_bg = color.pane_2
theme.tooltip_fg = color.fg
theme.tooltip_border_width = dpi(0)
theme.tooltip_shape = function(cr, width, height)
  gears.shape.rectangle(cr, width, height)
end

theme.notification_bg = color.pane_2
theme.notification_fg = color.fg
theme.notification_border_width = dpi(4)
theme.notification_border_color = color.border_active
theme.notification_shape = function(cr, width, height)
  gears.shape.rectangle(cr, width, height)
end
theme.notification_margin = dpi(10)
theme.notification_max_width = dpi(400)
theme.notification_max_height = dpi(1000)
theme.notification_icon_size = dpi(40)

theme.bg_systray = color.bg
theme.systray_icon_spacing = dpi(10)

theme.hotkeys_bg = color.bg
theme.hotkeys_fg = color.fg
theme.hotkeys_border_width = 0
theme.hotkeys_shape = function(cr, width, height)
  gears.shape.rectangle(cr, width, height)
end
theme.hotkeys_description_font = User_vars.font.bold

theme.layout_floating = gears.color.recolor_image(icons .. "/layout/floating.svg", color.bg)
theme.layout_tile = gears.color.recolor_image(icons .. "/layout/tile.svg", color.bg)

-- Wibar widget colors
-- TODO: Set these colors to fit the colorscheme
theme.wibar_audio_color = color.color1
theme.wibar_audio_hover_color = color.color3
theme.wibar_battery_color = color.color1
theme.wibar_battery_hover_color = color.color3
theme.wibar_bluetooth_color = color.color1
theme.wibar_bluetooth_hover_color = color.color3
theme.wibar_clock_color = color.color1
theme.wibar_clock_hover_color = color.color3
theme.wibar_date_color = color.color1
theme.wibar_date_hover_color = color.color3
theme.wibar_layout_list_color = color.color2
theme.wibar_layout_list_hover_color = color.color17
theme.wibar_power_color = color.color1
theme.wibar_power_hover_color = color.color3
theme.wibar_systray_color = color.color1
theme.wibar_systray_hover_color = color.color3
theme.wibar_wifi_color = color.color1
theme.wibar_wifi_hover_color = color.color3

return theme
