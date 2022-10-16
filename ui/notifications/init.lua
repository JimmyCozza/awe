local naughty = require "naughty"
local awful = require "awful"
local noscope = require "noscope"
local gears = require "gears"
local wibox = require "wibox"

naughty.connect_signal("request::display", function(n)
awful.spawn.easy_async_with_shell("echo " .. " - " .. n.app_name .. " - " .. n.urgency .. " - " .. n.title .. " - " .. n.text .. " >> ~/awe/test.txt")
  naughty.layout.box {
    notification = n,
    ontop = true,
    position = "top_right",
    border_width = 3,
    border_color = "#458588",
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
              --border_color = "#fb4934",
              strategy = "max",
              naughty.widget.icon,
            },
            {
              layout = wibox.layout.fixed.vertical,
              spacing = dpi(8),
              --border_color = "#fb4934",
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
