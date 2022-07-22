--------------------------------
-- This is the power widget --
--------------------------------

-- Awesome Libs
local awful = require "awful"
local colors = require "ui.colors"
local dpi = require("beautiful").xresources.apply_dpi
local gears = require "gears"
local wibox = require "wibox"
require "signals"

-- Icon directory path
local icondir = awful.util.getdir "config" .. "icons/power/"

return function()
  local power_widget = wibox.widget {
    {
      {
        {
          {
            {
              id = "icon",
              image = gears.color.recolor_image(icondir .. "power.svg", colors.bg),
              widget = wibox.widget.imagebox,
              resize = false,
            },
            id = "icon_layout",
            widget = wibox.container.place,
          },
          id = "icon_margin",
          top = dpi(2),
          widget = wibox.container.margin,
        },
        id = "power_layout",
        layout = wibox.layout.fixed.horizontal,
      },
      id = "container",
      left = dpi(8),
      right = dpi(8),
      widget = wibox.container.margin,
    },
    bg = colors.green,
    fg = colors.grey1,
    shape = function(cr, width, height)
      gears.shape.rectangle(cr, width, height)
    end,
    widget = wibox.container.background,
  }

  -- Signals
  Hover_signal(power_widget, colors.soft_green)

  power_widget:connect_signal("button::release", function()
    awesome.emit_signal "module::powermenu:show"
  end)

  return power_widget
end
