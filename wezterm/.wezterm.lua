-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = 'AdventureTime'

config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.colors = {
    background = '#0c0e13',
}

config.font = wezterm.font {
    family = "Menlo",
}
-- config.dpi = 75
-- config.freetype_load_target = "HorizontalLcd"
config.font_size = 12

-- and finally, return the configuration to wezterm
return config
