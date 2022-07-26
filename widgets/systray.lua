local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi
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
    bg = beautiful.wibar_systray_color,
  }
  -- Signals
  Hover_signal(systray.container, beautiful.wibar_systray_hover_color)

  systray.container.st.widget:set_base_size(dpi(20))

  return systray
end
