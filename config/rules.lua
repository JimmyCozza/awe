local awful = require "awful"
local ruled = require "ruled"

-- Clients should always start as slave instead of master
ruled.client.append_rule { rule = {}, properties = {}, callback = awful.client.setslave }

ruled.client.append_rule {
  rule_any = {
    instance = {},
    class = {
      "Arandr",
      "Lxappearance",
      "kdeconnect.app",
      "zoom",
      "file-roller",
      "File-roller",
    },
    name = {},
    role = {
      "AlarmWindow",
      "ConfigManager",
      "pop-up",
    },
  },
  properties = { floating = true, titlebars_enabled = true },
}

ruled.client.append_rule {
  id = "titlebar",
  rule_any = {
    type = { "normal", "dialog", "modal", "utility" },
  },
  properties = { titlebars_enabled = true },
}
