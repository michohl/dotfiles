-- Pull in wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration
local config = wezterm.config_builder()

config.color_scheme = 'Gruvbox Dark (Gogh)'

config.keys = {
  -- Stop new windows from appearing when using Neovim auto completion
  {
    key = 'n',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.DisableDefaultAssignment,
  },
  -- Switch tabs
  {
    key = 'RightArrow',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ActivateTabRelative(1),
  },
  {
    key = 'LeftArrow',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ActivateTabRelative(-1),
  },

}

-- Wayland isn't currently supported which is what I use in Fedora 40
-- https://github.com/wez/wezterm/issues/4962#issuecomment-2122189202
config.enable_wayland = false

-- Disable the terminal from making noises on typos
config.audible_bell = "Disabled"


return config
