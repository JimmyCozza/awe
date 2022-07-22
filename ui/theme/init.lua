local awful = require "awful"
local beautiful = require "beautiful"
local icons = awful.util.getdir "config" .. "icons/"

local theme = require("ui.theme." .. User_vars.theme)
theme.awesome_icon = icons .. "ArchLogo.png"
theme.awesome_subicon = icons .. "ArchLogo.png"
return theme
