--------------------------------------------------
--  ██████╗██████╗ ██╗   ██╗██╗     ██╗ █████╗  --
-- ██╔════╝██╔══██╗╚██╗ ██╔╝██║     ██║██╔══██╗ --
-- ██║     ██████╔╝ ╚████╔╝ ██║     ██║███████║ --
-- ██║     ██╔══██╗  ╚██╔╝  ██║     ██║██╔══██║ --
-- ╚██████╗██║  ██║   ██║   ███████╗██║██║  ██║ --
--  ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝╚═╝╚═╝  ╚═╝ --
--------------------------------------------------
------------------------------------------------------------------------------------------
-- This is the main themeing file, here are most colors changed                         --
-- If you want to change individual widget colors you will need to edit them seperately --
------------------------------------------------------------------------------------------

-- Awesome Libs
local color = require "ui.colors"
local dpi = require("beautiful.xresources").apply_dpi
local gears = require "gears"
local awful = require "awful"

-- Icon directory path
local icondir = awful.util.getdir "config" .. "icons/"
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

theme.useless_gap = dpi(10) -- Change this to 0 if you dont like window gaps
theme.border_width = dpi(0) -- Change this to 0 if you dont like borders
theme.border_normal = color["Grey800"]
--theme.border_focus = color["Red"] -- Doesnt work, no idea why; workaround is in signals.lua
theme.border_marked = color["Red400"]

--theme.menu_submenu_icon = theme_path .. "assets.ArchLogo.png"
theme.menu_height = dpi(40)
theme.menu_width = dpi(200)
theme.menu_bg_normal = color["Grey900"]
theme.menu_bg_focus = color["Grey800"]
theme.menu_fg_focus = color["White"]
theme.menu_border_color = color["Grey800"]
theme.menu_border_width = dpi(0)
theme.menu_shape = function(cr, width, heigth)
  gears.shape.rounded_rect(cr, width, heigth, 5)
end

theme.taglist_fg_focus = color["Grey900"]
theme.taglist_bg_focus = color["White"]

theme.tooltip_border_color = color["Grey900"]
theme.tooltip_bg = color["Grey800"]
theme.tooltip_fg = color["White"]
theme.tooltip_border_width = dpi(0)
theme.tooltip_shape = function(cr, width, heigth)
  gears.shape.rounded_rect(cr, width, heigth, 5)
end

theme.notification_bg = color["Grey900"]
theme.notification_fg = color["White"]
theme.notification_border_width = dpi(0)
theme.notification_border_color = color["Grey900"]
theme.notification_shape = function(cr, width, heigth)
  gears.shape.rounded_rect(cr, width, heigth, 10)
end
theme.notification_margin = dpi(10)
theme.notification_max_width = dpi(400)
theme.notification_max_height = dpi(1000)
theme.notification_icon_size = dpi(40)

theme.titlebar_close_button_normal = icondir .. "/titlebar/close.svg"
theme.titlebar_maximized_button_normal = icondir .. "/titlebar/maximize.svg"
theme.titlebar_minimize_button_normal = icondir .. "/titlebar/minimize.svg"
theme.titlebar_maximized_button_active = icondir .. "/titlebar/maximize.svg"
theme.titlebar_maximized_button_inactive = icondir .. "/titlebar/maximize.svg"

theme.bg_systray = color["BlueGrey800"]
theme.systray_icon_spacing = dpi(10)

theme.hotkeys_bg = color["Grey900"]
theme.hotkeys_fg = color["White"]
theme.hotkeys_border_width = 0
theme.hotkeys_shape = function(cr, width, height)
  gears.shape.rounded_rect(cr, width, height, 10)
end
theme.hotkeys_description_font = User_vars.font.bold

-- Here are the icons for the layouts defined, if you want to add more layouts go to main/layouts.lua
theme.layout_floating = gears.color.recolor_image(icondir .. "layout/floating.svg", color["Grey900"])
theme.layout_tile = gears.color.recolor_image(icondir .. "layout/tile.svg", color["Grey900"])
--theme.layout_dwindle = gears.color.recolor_image(layout_path .. "layout/dwindle.svg", color["Grey900"])
--theme.layout_fairh = gears.color.recolor_image(layout_path .. "layout/fairh.svg", color["Grey900"])
--theme.layout_fullscreen = gears.color.recolor_image(layout_path .. "layout/fullscreen.svg", color["Grey900"])
--theme.layout_max = gears.color.recolor_image(layout_path .. "layout/max.svg", color["Grey900"])

return theme
