local awful = require "awful"
local hotkeys_popup = require "awful.hotkeys_popup"
local beautiful = require "beautiful"
local naughty = require "naughty"
local gears = require "gears"

local function switch_configs(config)
  awful.spawn.with_shell("rm ~/.config/awesome && ln -s ~/unix_stuff/awesome_configs/" .. config .. " ~/.config/awesome")
  awesome.restart()
end

local function list_configs()
  local configs = {}

  awful.spawn.easy_async("ls /home/jimmy/unix_stuff/awesome_configs", function(stdout)
    local config_items = stdout:gmatch("[^\r\n]+")
      for s in config_items do
        gears.table.merge(configs, {
          {
            s,
            function()
              switch_configs(s)
            end,
          },
        })
      end
  end)
  return configs
end

local awesomemenu = {
  {
    "Key Binds",
    function()
      hotkeys_popup.show_help(nil, awful.screen.focused())
    end,
  },
  { "Manual", User_vars.apps.terminal .. " start man awesome" },
  { "Edit Config", User_vars.apps.editor .. " " .. awesome.conffile },
  { "Configs", list_configs() },
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

local mymainmenu = awful.menu {
  items = {
    { "AwesomeWM", awesomemenu, beautiful.awesome_icon },
    { "Apps", appmenu },
  },
}

return mymainmenu
