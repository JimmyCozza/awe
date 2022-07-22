local awful = require "awful"
local hotkeys_popup = require "awful.hotkeys_popup"
local noscope = require "noscope"

local M = {}

M.spawn_browser = function()
  awful.spawn.with_shell(User_vars.apps.browser)
end
M.spawn_screenshot = function()
  awful.spawn.with_shell(User_vars.apps.screenshot)
end
M.spawn_terminal = function()
  awful.spawn.with_shell(User_vars.apps.terminal)
end
M.spawn_filemanager = function()
  awful.spawn.with_shell(User_vars.apps.filemanager)
end
M.spawn_launcher = function()
  awful.spawn.with_shell(User_vars.apps.launcher)
end
M.spawn_notes = function()
  awful.spawn.with_shell(User_vars.apps.notes)
end
M.spawn_dropdown_term = function()
  awful.spawn.with_shell "tdrop -ma -w 63% -h 60% -x 2% alacritty"
end
M.noscope = function()
  noscope.launchNoscope()
  --awesome.emit_signal "noscope:show"
end
M.spawn_logout = function()
  awesome.emit_signal "module::powermenu:show"
end

return M
