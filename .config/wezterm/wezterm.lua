-- Pull in wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration
local config = wezterm.config_builder()

config.color_scheme = 'Gruvbox Dark (Gogh)'

config.keys = {
  {
    key = 'n',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.DisableDefaultAssignment,
  },
}

-- https://github.com/wez/wezterm/issues/4962#issuecomment-2122189202
config.enable_wayland = false

return config
