local awful = require "awful"
local wibox = require "wibox"
local beautiful = require "beautiful"
local widgets = require "widgets"
local gears = require "gears"

local function group_widgets(s, w, side)
  local left_margin
  local right_margin
  local items = {}
  for index, widget in ipairs(w) do
    if side == "left" then
      if index == 1 then
        left_margin = beautiful.useless_gap / 2
        right_margin = beautiful.useless_gap / 4
      else
        left_margin = beautiful.useless_gap / 4
        right_margin = beautiful.useless_gap / 4
      end
    else
      if index == #w then
        left_margin = beautiful.useless_gap / 4
        right_margin = beautiful.useless_gap / 2
      else
        left_margin = beautiful.useless_gap / 4
        right_margin = beautiful.useless_gap / 4
      end
    end
    table.insert(items, {
      widget(s),
      left = left_margin,
      right = right_margin,
      top = beautiful.useless_gap / 2,
      bottom = beautiful.useless_gap / 2,
      widget = wibox.container.margin,
    })
  end
  return wibox.widget {
    gears.table.join(items, {
      layout = wibox.layout.fixed.horizontal,
    }),
    margins = 0,
    layout = wibox.container.margin,
  }
end

return function(s)
  local bar = awful.popup {
    bg = global_colors.bg,
    ontop = false,
    placement = function(c)
      awful.placement.top(c, { margins = beautiful.useless_gap * 2 })
    end,
    screen = s,
    shape = function(cr, width, height)
      gears.shape.rectangle(cr, width, height)
    end,
    visible = true,
    widget = wibox.container.background,
  }

  -- From the docs:
  -- Struts are the area which should be reserved on each side of the screen for this wibox.
  -- This is used to make bars and docked displays.
  -- Note that awful.wibar implements all the required boilerplate code to make bar.
  -- Only use this if you want special type of bars (like bars not fully attached to the side of the screen).

  -- So to make this look a bar, I'll add a strut equal to the height of the bar,
  -- PLUS twice the useless_gap, so clients will have the same gap between each other and the bar.
  bar:struts {
    top = 45 + (beautiful.useless_gap * 2),
  }

  bar:setup {
    group_widgets(s, {
      widgets.layout_list,
      --widgets.systray,
    }, "left"), -- left
    --nil, -- center
    group_widgets(s, {
      --widgets.date,
    }, "center"),
    group_widgets(s, {
      widgets.wifi,
      widgets.battery,
      widgets.audio,
      widgets.clock,
      widgets.power,
    }, "right"),
    forced_height = 45,
    forced_width = s.geometry.width - beautiful.useless_gap * 4,
    layout = wibox.layout.align.horizontal,
    expand = "none",
  }
end
