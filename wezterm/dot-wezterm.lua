-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.font = wezterm.font("FiraMono Nerd Font Mono", { weight = "Regular", stretch = "Normal", style = "Normal" }) -- /Users/scsar/Library/Fonts/FiraMonoNerdFontMono-Regular.otf, CoreText
config.font_size = 12

if os.getenv("SWAYSOCK") then
  -- match openSUSEway alacritty
  config.window_background_opacity = 0.75
  config.window_frame = {
    inactive_titlebar_bg = "none",
    active_titlebar_bg = "none",
  }
else
  config.color_scheme = "nord"
end

-- and finally, return the configuration to wezterm
return config
