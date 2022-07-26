local awful = require "awful"
local wibox = require "wibox"
local gears = require "gears"
local colors = require "ui.colors"
local naughty = require "naughty"
local icons = "/home/jimmy/awesome/icons/"

local M = {}

local noscope_prompt = awful.widget.prompt()

local input = noscope_prompt.widget
local results = {}
--local previewer = {}
local menu_items = {
  {
    name = "Beekeeper Studio",
    icon_name = "ArchLogo.png",
    url = "https://www.reddit.com/r/awesomewm",
    version = "1.2",
  },
  { name = "Postman", icon_name = "ArchLogo.png", url = "http://github.com/", version = "2.2" },
  { name = "Neovim", icon_name = "ArchLogo.png", url = "https://stackoverflow.com/", version = "0.8" },
}

local function set_previewer(previewer)
  for _, item in ipairs(menu_items) do
    local row = wibox.widget {
      { -- background
        { -- margin
          { --image
            image = icons .. item.icon_name,
            forced_width = 16,
            forced_height = 16,
            widget = wibox.widget.imagebox,
          },
          { -- textbox
            text = item.name,
            widget = wibox.widget.textbox,
          },
          { -- 3rd "column" textbox
            text = item.version,
            widget = wibox.widget.textbox,
          },
          spacing = 12,
          layout = wibox.layout.fixed.horizontal,
        },
        margins = 4,
        layout = wibox.container.margin,
      },
      bg = colors.bg,
      widget = wibox.container.background,
    }
    local old_cursor, old_wibox
    row:connect_signal("mouse::enter", function(c)
      c:set_bg(colors.grey1)
      local wb = mouse.current_wibox
      old_cursor, old_wibox = wb.cursor, wb
      wb.cursor = "hand1"
    end)
    row:connect_signal("mouse::leave", function(c)
      c:set_bg(colors.bg)
      if old_wibox then
        old_wibox.cursor = old_cursor
        old_wibox = nil
      end
    end)

    row:buttons(awful.util.table.join(awful.button({}, 1, function()
      previewer.visible = not previewer.visible
      awful.spawn.with_shell("xdg-open " .. item.url)
    end)))
    table.insert(previewer, row)
  end
  return previewer
end

local function new_previewer()
  local previewer = { layout = wibox.layout.fixed.vertical }
  return set_previewer(previewer)
end

local function set_picker(picker)
  return picker
end

local function new_picker()
  local picker = { layout = wibox.layout.fixed.vertical }
  return set_picker(picker)
end

local noscope = awful.popup {
  widget = {},
  border_color = colors.green,
  border_width = 2,
  placement = awful.placement.centered,
  shape = gears.shape.rectangle,
  visible = false,
  ontop = true,
  hide_on_right_click = true,
  layout = wibox.layout.grid,
}

local function whole_damned_thing()
  --local previewer = new_previewer()
  --noscope:setup(previewer)
  -- return full widget to belong to noscope, then setup noscope
  -- assign forced_height & forced_width
  -- forced_height = 600,
  -- forced_width = 400,
  -- New Prompt (use ripgrep)
  -- New Results
  -- New Previewer
  --noscope:setup { --Declarative.  Doesn't span right...
  --previewer,
  --{
  --text   = "foobar",
  --widget = wibox.widget.textbox
  --},
  --{
  --{
  --text   = "foobar",
  --widget = wibox.widget.textbox
  --},
  --bg     = "#ff00ff",
  --clip   = true,
  --shape  = gears.shape.rounded_bar,
  --widget = wibox.widget.background
  --},
  --layout = wibox.layout.grid,
  --}
  --noscope:add_widget_at(previewer, 1, 2, 1, 1)
end

M.launchNoscope = function()
  naughty.notify {
    text = "NOSCOPE",
    timeout = 2,
    --icon = icondir .. "suspend.svg",
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
  local previewer = new_previewer()
  noscope:setup(previewer)
  --whole_damned_thing()
  noscope.visible = true
end

awesome.connect_signal("popups:hide", function()
  noscope.visible = false
end)

return M
