local awful = require "awful"
local naughty = require "naughty"
local mymainmenu = require "ui.menu"

local function clear_noise()
  naughty.destroy_all_notifications()
  awesome.emit_signal "popups:hide"
end

local mouse_bindings = {
  awful.button({}, 1, clear_noise),
  awful.button({}, 3, function()
    mymainmenu:toggle()
  end),
  awful.button({}, 4, awful.tag.viewprev),
  awful.button({}, 5, awful.tag.viewnext),
}

local signal_bindings = {
  awful.button({}, 1, function(c)
    c:activate { context = "mouse_click" }
  end),
  awful.button({ modkey }, 1, function(c)
    c:activate { context = "mouse_click", action = "mouse_move" }
  end),
  awful.button({ modkey }, 3, function(c)
    c:activate { context = "mouse_click", action = "mouse_resize" }
  end),
}

return {
  standard = mouse_bindings,
  signal = signal_bindings,
}
