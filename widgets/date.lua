local awful = require "awful"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi
local gears = require "gears"
local wibox = require "wibox"
require "signals"

-- Icon directory path
local icondir = awful.util.getdir "config" .. "icons/date/"

-- Returns the date widget
return function()
  local date_widget = wibox.widget {
    {
      {
        {
          {
            {
              id = "icon",
              image = gears.color.recolor_image(icondir .. "calendar.svg", beautiful.bg_normal),
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
        id = "date_layout",
        layout = wibox.layout.fixed.horizontal,
      },
      id = "container",
      left = dpi(8),
      right = dpi(8),
      widget = wibox.container.margin,
    },
    bg = beautiful.wibar_date_color,
    fg = beautiful.bg_normal,
    shape = function(cr, width, height)
      gears.shape.rectangle(cr, width, height, 5)
    end,
    widget = wibox.container.background,
  }

  local set_date = function()
    date_widget.container.date_layout.label:set_text(os.date "%a, %b %d")
  end

  gears.timer {
    timeout = 60,
    autostart = true,
    call_now = true,
    callback = function()
      set_date()
    end,
  }

  -- Signals
  Hover_signal(date_widget, beautiful.wibar_date_hover_color)

  date_widget:connect_signal("mouse::enter", function()
    awesome.emit_signal("widget::calendar_osd:stop", true)
  end)

  date_widget:connect_signal("mouse::leave", function()
    awesome.emit_signal("widget::calendar_osd:rerun", true)
  end)

  return date_widget
end
