local awful = require "awful"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi
local gears = require "gears"
local wibox = require "wibox"
local icondir = awful.util.getdir "config" .. "icons/network/"

return function()
  local wifi = wibox.widget {
    {
      {
        {
          {
            id = "icon",
            image = gears.color.recolor_image(icondir .. "wifi-strength-1.svg", beautiful.bg_normal),
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
      id = "container",
      left = dpi(8),
      right = dpi(8),
      widget = wibox.container.margin,
    },
    bg = beautiful.wibar_wifi_color,
    fg = beautiful.fg_normal,
    shape = function(cr, width, height)
      gears.shape.rectangle(cr, width, height)
    end,
    widget = wibox.container.background,
  }

  local wifi_tooltip = awful.tooltip {
    text = "Connecting",
    objects = { wifi },
    mode = "inside",
    preferred_alignments = "middle",
    margins = dpi(10),
  }

  local function update_ssid()
    awful.spawn.easy_async("iwgetid -r", function(stdout)
      local tooltip_msg = ""
      if stdout == "Not connected." then
        tooltip_msg = stdout
      else
        tooltip_msg = "Network: " .. stdout
      end
      wifi_tooltip:set_markup(tooltip_msg)
    end)
  end

  -- TODO: Add strength to the tooltop
  local function update_strength()
    awful.spawn.easy_async([[ awk 'NR==3 {printf "%3.0f", ($3/70)*100}' /proc/net/wireless ]], function(stdout)
      if not tonumber(stdout) then
        return
      end
      local wifi_strength = tonumber(stdout)
      --wifi.container.network_layout.spacing = dpi(8)
      --wifi.container.network_layout.label.visible = true
      --wifi.container.network_layout.label:set_text(tostring(wifi_strength .. "%"))
      local wifi_strength_rounded = math.floor(wifi_strength / 25 + 0.5)
      wifi.container.icon_margin.icon_layout.icon:set_image(
        gears.color.recolor_image(icondir .. "wifi-strength-" .. wifi_strength_rounded .. ".svg", beautiful.bg_normal)
      )
    end)
  end

  local function update_wifi()
    update_ssid()
    update_strength()
  end

  gears.timer {
    timeout = 15,
    call_now = true,
    autostart = true,
    callback = update_wifi
  }

  Hover_signal(wifi, beautiful.wibar_wifi_hover_color)

  -- TODO: Add prettier applet instead of the xfce one
  wifi:connect_signal("button::press", function()
    awful.spawn ""
  end)

  return wifi
end
