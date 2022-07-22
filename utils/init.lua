-- This is really just a port of https://github.com/arcolinux/archlinux-logout, which I love
local awful = require "awful"
local dpi = require("beautiful").xresources.apply_dpi
local gears = require "gears"
local wibox = require "wibox"
local icons = awful.util.getdir "config" .. "icons/logout/"

local M = {}

-- TODO: Add signal to use ${command}_blur.svg image to widget on mouse enter
M.logout = function(s)
  local set_prompt = function(key, command, callback)
    local icon = icons .. command
    local item = wibox.widget {
      {
        -- TODO: Align these horizontally
        {
          image = icon .. ".svg",
          resize = true,
          forced_height = 200,
          widget = wibox.widget.imagebox,
          id = "actual_button",
        },
        {
          text = command .. " (" .. key .. ")",
          align = "center",
          valign = "center",
          widget = wibox.widget.textbox,
        },
        align = "center",
        layout = wibox.layout.align.vertical,
      },
      widget = wibox.container.background,
      id = "background",
    }

    item:connect_signal("button::release", function()
      callback()
    end)

    return item
  end

  local hide_powermenu = function()
    awesome.emit_signal "module::powermenu:hide"
  end

  local suspend_command = function()
    awful.spawn "systemctl suspend"
    hide_powermenu()
  end

  local logout_command = function()
    awesome.quit()
  end

  local lock_command = function()
    awful.spawn "dm-tool lock"
    hide_powermenu()
  end

  local shutdown_command = function()
    awful.spawn "systemctl poweroff"
    hide_powermenu()
  end

  local restart_command = function()
    awful.spawn "reboot"
    hide_powermenu()
  end

  local shutdown_button = set_prompt("s", "shutdown", shutdown_command)
  local restart_button = set_prompt("r", "restart", restart_command)
  local suspend_button = set_prompt("u", "suspend", suspend_command)
  local logout_button = set_prompt("l", "logout", logout_command)
  local lock_button = set_prompt("k", "lock", lock_command)

  local powermenu = wibox.widget {
    layout = wibox.layout.align.vertical,
    expand = "none",
    nil,
    {
      {
        nil,
        nil,
        nil,
        expand = "none",
        layout = wibox.layout.align.horizontal,
      },
      {
        nil,
        {
          {
            shutdown_button,
            restart_button,
            logout_button,
            lock_button,
            suspend_button,
            spacing = dpi(100),
            layout = wibox.layout.fixed.horizontal,
          },
          margins = dpi(0),
          widget = wibox.container.margin,
        },
        nil,
        expand = "none",
        layout = wibox.layout.align.horizontal,
      },
      layout = wibox.layout.align.vertical,
    },
    nil,
  }

  local powermenu_container = wibox {
    widget = powermenu,
    screen = s,
    type = "splash",
    visible = false,
    ontop = true,
    bg = "#212121aa",
    height = s.geometry.height,
    width = s.geometry.width,
    x = s.geometry.x,
    y = s.geometry.y,
  }

  powermenu_container:buttons(gears.table.join(awful.button({}, 3, function()
    awesome.emit_signal "module::powermenu:hide"
  end)))

  local powermenu_keygrabber = awful.keygrabber {
    autostart = false,
    stop_event = "release",
    keybindings = {
      awful.key {
        modifiers = {},
        key = "Escape",
        on_press = hide_powermenu,
      },
      awful.key {
        modifiers = {},
        key = "r",
        on_press = restart_command,
      },
      awful.key {
        modifiers = {},
        key = "s",
        on_press = shutdown_command,
      },
      awful.key {
        modifiers = {},
        key = "u",
        on_press = suspend_command,
      },
      awful.key {
        modifiers = {},
        key = "k",
        on_press = lock_command,
      },
      awful.key {
        modifiers = {},
        key = "l",
        on_press = logout_command,
      },
    },
  }

  awesome.connect_signal("module::powermenu:show", function()
    if s == mouse.screen then
      powermenu_container.visible = true
      powermenu_keygrabber:start()
    end
  end)

  awesome.connect_signal("module::powermenu:hide", function()
    powermenu_keygrabber:stop()
    powermenu_container.visible = false
  end)
end

return M
