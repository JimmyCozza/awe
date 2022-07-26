----------------------------------
-- This is the layoutbox widget --
----------------------------------

-- Awesome Libs
local awful = require "awful"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi
local gears = require "gears"
local wibox = require "wibox"
require "signals"

-- Returns the layoutbox widget
return function()
  local layout = wibox.widget {
    {
      {
        awful.widget.layoutbox(),
        id = "icon_layout",
        widget = wibox.container.place,
      },
      id = "icon_margin",
      left = dpi(5),
      right = dpi(5),
      forced_width = dpi(40),
      widget = wibox.container.margin,
    },
    bg = beautiful.wibar_layout_list_color,
    shape = function(cr, width, height)
      gears.shape.rectangle(cr, width, height, 5)
    end,
    widget = wibox.container.background,
  }

  -- Signals
  Hover_signal(layout, beautiful.wibar_layout_list_hover_color)

  layout:connect_signal("button::press", function()
    awful.layout.inc(1)
  end)

  return layout
end
