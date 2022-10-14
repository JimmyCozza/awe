local awful = require "awful"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi
local gears = require "gears"
local wibox = require "wibox"
require "signals"

-- Icon directory path
local icondir = awful.util.getdir "config" .. "icons/clock/"

-- Returns the clock widget
return function()
  local clock_widget = wibox.widget {
    {
      {
        {
          {
            {
              id = "icon",
              image = gears.color.recolor_image(icondir .. "clock.svg", beautiful.bg_normal),
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
        spacing = dpi(10),
        {
          id = "label",
          align = "center",
          valign = "center",
          widget = wibox.widget.textbox,
        },
        id = "clock_layout",
        layout = wibox.layout.fixed.horizontal,
      },
      id = "container",
      left = dpi(8),
      right = dpi(8),
      widget = wibox.container.margin,
    },
    bg = beautiful.wibar_clock_color,
    fg = beautiful.bg_normal,
    shape = function(cr, width, height)
      gears.shape.rectangle(cr, width, height)
    end,
    widget = wibox.container.background,
  }

  local set_clock = function()
    clock_widget.container.clock_layout.label:set_text(os.date "%I:%M")
  end

  -- TODO: Move timers to the signals dir.
  -- Emit signals and connect to them in widgets
  -- instead of calling a function that modifies the widgets directly by id
  gears.timer {
    timeout = 5,
    autostart = true,
    call_now = true,
    callback = function()
      set_clock()
    end,
  }

  Hover_signal(clock_widget, beautiful.wibar_clock_hover_color)

  return clock_widget
end
