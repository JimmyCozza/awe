local awful = require "awful"
local hotkeys_popup = require "awful.hotkeys_popup"
local beautiful = require "beautiful"
local naughty = require "naughty"
local utils = require "utils"

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

local appmenu = {
  { "Terminal", User_vars.apps.terminal },
  { "Editor", User_vars.apps.editor },
  { "Chat", User_vars.apps.discord }
}


local function switch_configs(config)
  awful.spawn.with_shell("rm ~/.config/awesome && ln -s ~/unix_stuff/awesome_configs/" .. config .. " ~/.config/awesome")
  awesome.restart()
end

local mymainmenu = awful.menu {
  items = {
    { "AwesomeWM", awesomemenu, beautiful.awesome_icon },
    { "Apps", appmenu },
    {
      "Configs",
      {
        {
          "jimmy",
          function()
            switch_configs("jimmy")
          end
        },
        {
          "awesome-from-scratch",
          function()
            switch_configs("awesome-from-scratch")
          end
        },
      }
    },
  },
}

return mymainmenu
