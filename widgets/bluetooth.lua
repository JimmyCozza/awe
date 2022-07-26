local awful = require "awful"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi
local gears = require "gears"
local wibox = require "wibox"
local icondir = awful.util.getdir "config" .. "icons/bluetooth/"

return function()
  local bluetooth = wibox.widget {
    {
      {
        {
          {
            {
              id = "icon",
              image = gears.color.recolor_image(icondir .. "bluetooth-on.svg", beautiful.bg_normal),
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
    bg = beautiful.wibar_bluetooth_color,
    fg = beautiful.bg_normal,
    shape = function(cr, width, height)
      gears.shape.rectangle(cr, width, height)
    end,
    widget = wibox.container.background,
  }
  return bluetooth
end
