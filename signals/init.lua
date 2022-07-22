-- These daemons are props to elenapan (except battery).
-- https://github.com/elenapan/dotfiles
--require("signal.battery")
require "signals.brightness"
require "signals.cpu"
--require "signals.disk"
require "signals.ram"
require "signals.temp"
require "signals.volume"

local sh = require "signals.helpers"

local function connect_signals(signals, type)
  for _, signal in ipairs(signals) do
    type.connect_signal(signal[1], signal[2])
  end
end

local screen_signals = {
  { "added", awesome.restart },
  { "removed", awesome.restart },
  { "logout", sh.logout },
}

local client_signals = {
  { "manage", sh.manage_client },
  { "unmanage", sh.unmanage_client },
  { "tag::switched", sh.switch_tags },
  { "focus", sh.apply_border_color },
  { "unfocus", sh.reset_border_color },
}

connect_signals(screen_signals, screen)
connect_signals(client_signals, client)

function Hover_signal(widget, bg, fg)
  local old_wibox, old_cursor, old_bg, old_fg
  widget:connect_signal("mouse::enter", function()
    if bg then
      old_bg = widget.bg
      if string.len(bg) == 7 then
        widget.bg = bg .. "dd"
      else
        widget.bg = bg
      end
    end
    if fg then
      old_fg = widget.fg
      widget.fg = fg
    end
    local w = mouse.current_wibox
    if w then
      old_cursor, old_wibox = w.cursor, w
      w.cursor = "hand1"
    end
  end)

  widget:connect_signal("button::press", function()
    if bg then
      if bg then
        if string.len(bg) == 7 then
          widget.bg = bg .. "bb"
        else
          widget.bg = bg
        end
      end
    end
    if fg then
      widget.fg = fg
    end
  end)

  widget:connect_signal("button::release", function()
    if bg then
      if bg then
        if string.len(bg) == 7 then
          widget.bg = bg .. "dd"
        else
          widget.bg = bg
        end
      end
    end
    if fg then
      widget.fg = fg
    end
  end)

  widget:connect_signal("mouse::leave", function()
    if bg then
      widget.bg = old_bg
    end
    if fg then
      widget.fg = old_fg
    end
    if old_wibox then
      old_wibox.cursor = old_cursor
      old_wibox = nil
    end
  end)
end
