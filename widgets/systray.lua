--------------------------------
-- This is the power widget --
--------------------------------

-- Awesome Libs
local dpi = require("beautiful").xresources.apply_dpi
local colors = require "ui.colors"
local gears = require "gears"
local wibox = require "wibox"
require "signals"

return function()
  local systray = wibox.widget {
    {
      {
        wibox.widget.systray(),
        margins = dpi(6),
        widget = wibox.container.margin,
        id = "st",
      },
      strategy = "exact",
      layout = wibox.container.constraint,
      id = "container",
    },
    widget = wibox.container.background,
    shape = function(cr, width, height)
      gears.shape.rectangle(cr, width, height)
    end,
    bg = colors.grey2,
  }
  -- Signals
  Hover_signal(systray.container, colors.grey1)

  systray.container.st.widget:set_base_size(dpi(20))

  return systray
end
