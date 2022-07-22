local awful = require "awful"
local hotkeys_popup = require "awful.hotkeys_popup"
local beautiful = require "beautiful"

local awesomemenu = {
  {
    "Key Binds",
    function()
      hotkeys_popup.show_help(nil, awful.screen.focused())
    end,
  },
  { "Manual", User_vars.apps.terminal .. " start man awesome" },
  { "Edit Config", User_vars.apps.editor .. " " .. awesome.conffile },
  { "Restart", awesome.restart },
  {
    "Quit",
    function()
      awesome.quit()
    end,
  },
}

local appmenu =
  { { "Terminal", User_vars.apps.terminal }, { "Editor", User_vars.apps.editor }, { "Chat", User_vars.apps.discord } }

local mymainmenu = awful.menu {
  items = {
    { "AwesomeWM", awesomemenu, beautiful.awesome_icon },
    { "Apps", appmenu },
  },
}

return mymainmenu
