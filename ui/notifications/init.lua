local naughty = require "naughty"
local awful = require "awful"
local noscope = require "noscope"
local beautiful = require "beautiful"
local gears = require "gears"
local wibox = require "wibox"

naughty.connect_signal("request::display", function(n)
  gears.debug.dump(n)
  awful.spawn.easy_async_with_shell(
    "echo " .. " - " .. n.app_name .. " - " .. n.urgency .. " - " .. n.title .. " - " .. n.text .. " >> ~/awe/test.txt"
  )

  --local note = awful.popup {
    --widget = {
      --{
        --{
          --widget = wibox.container.margin,
          --margins = dpi(12),
          --{
            --widget = wibox.widget.imagebox,
            --image = n.icon,
          --},
        --},
        --{
          --{
            --{
              --widget = wibox.widget.textbox,
              --text = n.title,
            --},
            --{
              --widget = wibox.widget.textbox,
              --text = n.text,
            --},
            --{
              --{
                --widget = wibox.widget.textbox,
                --text = "button",
              --},
              --{
                --widget = wibox.widget.textbox,
                --text = "button",
              --},
              --{
                --widget = wibox.widget.textbox,
                --text = "button",
              --},
              --min_width = dpi(300),
              --layout = wibox.layout.flex.horizontal,
            --},
            --layout = wibox.layout.fixed.vertical,
          --},
          --widget = wibox.container.margin,
          --margins = {
            --top = dpi(12),
            --right = dpi(12),
            --bottom = dpi(12),
            --left = 0,
          --},
        --},
        --layout = wibox.layout.fixed.horizontal,
      --},
      --bg = "#ff0000",
      ----forced_height = dpi(340),
      ----forced_width = dpi(500),
      --widget = wibox.container.background,
    --},
    --border_color = "#b8bb26",
    --border_width = 2,
    --placement = awful.placement.centered,
    --shape = gears.shape.rectangle,
    --visible = false,
    --ontop = true,
    --hide_on_right_click = true,
    --layout = wibox.layout.grid,
  --}
  --note.visible = true
end)
