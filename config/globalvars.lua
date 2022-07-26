local awful = require "awful"
local beautiful = require "beautiful"
dpi = beautiful.xresources.apply_dpi

-- Default Applications
local terminal = "wezterm"
local editor = "emacsclient -c"
local editor_cmd = editor
local browser = "google-chrome-stable"
local filemanager = "thunar"
local screenshot = "flameshot gui"
local discord = "discord"
local launcher = "~/.config/rofi/launchers/text/launcher.sh"
local music = terminal .. " --class music -e ncspot"
local emoji_launcher = "rofi -show emoji"
local notes = "tdrop -ma -w 63% -h 60% -x 2% emacs"

-- Global Vars
--screen_width = awful.screen.focused().geometry.width
--screen_height = awful.screen.focused().geometry.height
modkey = "Mod4"
altkey = "Mod1"
shift = "Shift"
ctrl = "Control"

-- If you want different default programs, wallpaper path or modkey; edit this file.
User_vars = {
  apps = {
    terminal = terminal,
    editor = editor,
    editor_cmd = editor_cmd,
    browser = browser,
    filemanager = filemanager,
    screenshot = screenshot,
    discord = discord,
    launcher = launcher,
    music = music,
    emoji_launcher = emoji_launcher,
    notes = notes,
  },
  -- TODO: Add nord & others
  -- gruvbox, catppuccin
  colorscheme = "catppuccin",
  sub_theme = "macchiato",
  theme = "boxy",
  bar_ui = "boxy",
  -- Autotiling layouts
  layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.floating,
    awful.layout.suit.fair,
  },
  icon_theme = "Papirus-Dark",
  network = {
    wlan = "wlan0",
    ethernet = "eno1",
  },
  font = {
    regular = "JetBrains Mono Nerd Font, 14",
    bold = "JetBrains Mono Nerd Font, bold 14",
    extrabold = "JetBrains Mono Nerd Font, ExtraBold 14",
  },
}
