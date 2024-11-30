-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.color_scheme = 'nord'
config.font = wezterm.font("FiraMono Nerd Font Mono", {weight="Regular", stretch="Normal", style="Normal"}) -- /Users/scsar/Library/Fonts/FiraMonoNerdFontMono-Regular.otf, CoreText
config.font_size = 14

config.default_cursor_style = 'SteadyBar'

-- and finally, return the configuration to wezterm
return config
