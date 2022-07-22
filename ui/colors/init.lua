local gears = require "gears"

local base_colors = require "ui.colors.crylia"
local user_colors = require("ui.colors." .. User_vars.colorscheme)

global_colors = (gears.table.join(base_colors, user_colors))

return global_colors
