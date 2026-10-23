-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()
local is_macos = wezterm.target_triple:find("darwin") ~= nil
local has_external_monitor = false

-- This is where you actually apply your config choices

config.font = wezterm.font("FiraMono Nerd Font Mono", { weight = "Regular", stretch = "Normal", style = "Normal" }) -- /Users/scsar/Library/Fonts/FiraMonoNerdFontMono-Regular.otf, CoreText
config.font_size = 12

config.color_scheme = "nord"

if os.getenv("SWAYSOCK") then
  -- match openSUSEway alacritty
  config.window_background_opacity = 0.75
  config.window_frame = {
    inactive_titlebar_bg = "none",
    active_titlebar_bg = "none",
  }
end

-- this was to stop flickering on my external monitor at work
if is_macos then
  config.front_end = "Software"
end

-- and finally, return the configuration to wezterm
return config
