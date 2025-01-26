-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- https://wezfurlong.org/wezterm/config/font-shaping.html#advanced-font-shaping-options
config.font = wezterm.font_with_fallback {
    "Monoid Nerd Font Mono",
    "Fira Code",
    "Hack",
    "DejaVu Sans Mono",
    "Noto Color Emoji",
}
config.font_size = 12
config.freetype_load_flags = "NO_HINTING"
-- config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0', }
config.color_scheme = 'Zenburn'
-- config.window_close_confirmation = 'NeverPrompt'

config.skip_close_confirmation_for_processes_named = {
  'bash',
  'sh',
  'zsh',
  'tmux',
--   https://github.com/wez/wezterm/issues/2783#issuecomment-1462266895 
  'flatpak-spawn',
}
config.window_background_opacity = 0.95

config.use_dead_keys = false
config.scrollback_lines = 10000

config.initial_cols = 100
config.initial_rows = 35

-- and finally, return the configuration to wezterm
return config
