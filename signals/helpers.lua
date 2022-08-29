local awful = require "awful"
local beautiful = require "beautiful"
local naughty = require "naughty"

local M = {}

M.manage_client = function(c)
  if awesome.startup and not c.size_hints.user_porition and not c.size_hints.program_position then
    awful.placement.no_offscreen(c)
  end
end

M.unmanage_client = function()
  if #awful.screen.focused().clients > 0 then
    awful.screen.focused().clients[1]:emit_signal("request::activate", "mouse_enter", {
      raise = true,
    })
  end
end

M.switch_tags = function()
  if #awful.screen.focused().clients > 0 then
    awful.screen.focused().clients[1]:emit_signal("request::activate", "mouse_enter", {
      raise = true,
    })
  end
end

M.apply_border_color = function(c)
  c.border_color = global_colors.orange
end

M.reset_border_color = function(c)
  c.border_color = beautiful.border_normal
end

M.logout = function(s)
  local icondir = awful.util.getdir "config" .. "icons/powermenu/"
  -- Username textbox
  local profile_name = wibox.widget {
    align = "center",
    valign = "center",
    text = " ",
    font = "JetBrainsMono Bold 30",
    widget = wibox.widget.textbox,
  }

  -- Will determin the display style
  local namestyle = User_vars.namestyle
  -- Get the full username(if set) and the username + hostname
  local update_user_name = function()
    awful.spawn.easy_async_with_shell([=[
                fullname="$(getent passwd `whoami` | cut -d ':' -f 5)"
                user="$(whoami)"
                host="$(hostname)"
                if [[ "]=] .. namestyle .. [=[" == "userhost" ]];
                then
                    printf "$user@$host"
                elif [[ "]=] .. namestyle .. [=[" == "fullname" ]];
                then
                    printf "$fullname"
                else
                    printf "User"
                fi
            ]=], function(stdout)
      profile_name:set_text(stdout)
    end)
  end
  update_user_name()

  -- Universal Button widget
  local button = function(name, icon, bg_color, callback)
    local item = wibox.widget {
      {
        {
          {
            {
              {
                -- TODO: using gears.color to recolor a SVG will make it look super low res
                -- currently I recolor it in the .svg file directly, but later implement
                -- a better way to recolor a SVG
                -- image = gears.color.recolor_image(icon, global_colors["Grey900"]),
                image = icon,
                resize = true,
                forced_height = dpi(30),
                widget = wibox.widget.imagebox,
              },
              margins = dpi(0),
              widget = wibox.container.margin,
            },
            {
              {
                text = name,
                font = "JetBrainsMono Bold 30",
                widget = wibox.widget.textbox,
              },
              margins = dpi(0),
              widget = wibox.container.margin,
            },
            widget = wibox.layout.fixed.horizontal,
          },
          margins = dpi(10),
          widget = wibox.container.margin,
        },
        fg = global_colors["Grey900"],
        bg = bg_color,
        shape = function(cr, width, height)
          gears.shape.rounded_rect(cr, width, height, 10)
        end,
        widget = wibox.container.background,
        id = "background",
      },
      spacing = dpi(0),
      layout = wibox.layout.align.vertical,
    }

    item:connect_signal("button::release", function()
      callback()
    end)

    return item
  end

  local hide_powermenu = function()
    awesome.emit_signal "module::powermenu:hide"
  end

  -- Create the power menu actions
  local suspend_command = function()
    naughty.notify {
      text = "Suspending...",
      timeout = 2,
      icon = icondir .. "suspend.svg",
      icon_size = dpi(100),
      hover_timeout = 1,
      position = "bottom_right",
      bg = "#1B1D1E",
      fg = "#A3A3A3",
      width = dpi(300),
      height = dpi(100),
      border_color = "#A3A3A3",
      border_width = dpi(1),
      ontop = true,
    }
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

  local reboot_command = function()
    awful.spawn "reboot"
    hide_powermenu()
  end

  -- Create the buttons with their command and name etc
  local shutdown_button = button("SHUT IT DOWN", icondir .. "shutdown.svg", global_colors.blue, shutdown_command)
  local reboot_button = button("Reboot", icondir .. "reboot.svg", global_colors.red, reboot_command)
  local suspend_button = button("Suspend", icondir .. "suspend.svg", global_colors.yellow, suspend_command)
  local logout_button = button("Logout", icondir .. "logout.svg", global_colors.green, logout_command)
  local lock_button = button("Lock", icondir .. "lock.svg", global_colors.orange, lock_command)

  -- Signals to change color on hover
  Hover_signal(shutdown_button.background, global_colors.blue)
  Hover_signal(reboot_button.background, global_colors.red)
  Hover_signal(suspend_button.background, global_colors.yellow)
  Hover_signal(logout_button.background, global_colors.green)
  Hover_signal(lock_button.background, global_colors.orange)

  -- The powermenu widget
  local powermenu = wibox.widget {
    layout = wibox.layout.align.vertical,
    expand = "none",
    nil,
    {
      {
        nil,
        {
          spacing = dpi(50),
          {
            profile_name,
            margins = dpi(0),
            widget = wibox.container.margin,
          },
          layout = wibox.layout.fixed.vertical,
        },
        nil,
        expand = "none",
        layout = wibox.layout.align.horizontal,
      },
      {
        nil,
        {
          {
            shutdown_button,
            reboot_button,
            logout_button,
            lock_button,
            suspend_button,
            spacing = dpi(30),
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

  -- Container for the widget, covers the entire screen
  local powermenu_container = wibox {
    widget = powermenu,
    screen = s,
    type = "splash",
    visible = false,
    ontop = true,
    bg = "#21212188",
    height = s.geometry.height,
    width = s.geometry.width,
    x = s.geometry.x,
    y = s.geometry.y,
  }

  -- Close on rightclick
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
        on_press = reboot_command,
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

  -- Signals
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
