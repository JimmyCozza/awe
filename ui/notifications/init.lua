local naughty = require "naughty"
local gears = require "gears"
local wibox = require "wibox"

naughty.connect_signal("request::display", function(n)
  naughty.layout.box {
    notification = n,
    ontop = true,
    position = "top_right",
    shape = gears.shape.rectangle,
    widget_template = {
      widget = wibox.container.constraint,
      width = dpi(500),
      strategy = "max",
      {
        margins = dpi(12),
        widget = wibox.container.margin,
        {
          layout = wibox.layout.fixed.vertical,
          spacing = dpi(10),
          naughty.list.actions,
          {
            layout = wibox.layout.fixed.horizontal,
            fill_space = true,
            spacing = dpi(16),
            {
              widget = wibox.container.constraint,
              width = dpi(48),
              height = dpi(48),
              strategy = "max",
              naughty.widget.icon,
            },
            {
              layout = wibox.layout.fixed.vertical,
              spacing = dpi(8),
              naughty.widget.title,
              naughty.widget.message {
                spacing = dpi(8),
                layout = wibox.layout.fixed.horizontal,
                naughty.widget.image,
                naughty.widget.image,
                naughty.widget.image,
              },
            },
          },
        },
      },
    },
  }
end)
