local awful = require "awful"
local gears = require "gears"
local hotkeys_popup = require "awful.hotkeys_popup"

local app_launcher = require "modules.bling".widget.app_launcher{
  terminal = "alacritty",
  favorites = { "wezterm" },
    --search_commands = { "test" },
    --skip_names = {"Discord"},
    --skip_commands ="",
    --skip_empty_icons = true,
    --sort_alphabetically = false,
    --reverse_sort_alphabetically = true,
    --select_before_spawn = true,
    --hide_on_left_clicked_outside = true,
    --hide_on_right_clicked_outside = false,
    --hide_on_launch = false,
    --try_to_keep_index_after_searching = true,
    --reset_on_hide = true,
    --save_history = true,
    --wrap_page_scrolling = false,
    --wrap_app_scrolling = true,
    --default_app_icon_name = nil,
    --default_app_icon_path ="",
    --icon_theme ="",
    --icons_size ="",
    --type = "normal",
    --show_on_focused_screen = "",
    --screen = "",
    --placement = awful.placement.left,
    --rubato = "",
    --shrink_width = true,
    --shrink_height = true,
    --background = "",
    shape = function(cr, width, height)
      gears.shape.rectangle(cr, width, height)
    end,

    --prompt_height = "",
    --prompt_margins = "",
    --prompt_paddings = "",
    --prompt_shape = "",
    --prompt_color = "",
    --prompt_border_width = "",
    --prompt_border_color = "",
    --prompt_text_halign = "",
    --prompt_text_valign = "",
    --prompt_icon_text_spacing = "",
    prompt_show_icon = false,
    --prompt_icon_font = "",
    --prompt_icon_color = "",
    --prompt_icon = "",
    --prompt_icon_markup = "",
    --prompt_text = "",
    --prompt_start_text = "",
    --prompt_font = "",
    --prompt_text_color = "",
    --prompt_cursor_color = "",

    --apps_per_row = 1,
    --apps_per_column = 1,
    --apps_margin = "",
    --apps_spacing = "",

    --expand_apps = "",
    --app_width = "",
    --app_height = "",
    --app_shape = "",
    --app_normal_color = "",
    --app_normal_hover_color = "",
    --app_selected_color = "",
    --app_selected_hover_color = "",
    --app_content_padding = "",
    --app_content_spacing = "",
    --app_show_icon = "",
    --app_icon_halign = "",
    --app_icon_width = "",
    --app_icon_height = "",
    --app_show_name = "",
    --app_name_generic_name_spacing = "",
    --app_name_halign = "",
    --app_name_font = "",
    --app_name_normal_color = "",
    --app_name_selected_color = "",
    --app_show_generic_name = "",
}

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
M.bling_launcher = function()
  app_launcher:toggle()
end
M.spawn_logout = function()
  awesome.emit_signal "module::powermenu:show"
end

return M
