-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = 'AdventureTime'
--

config.front_end = "WebGpu"

config.enable_tab_bar = false
config.window_decorations = "INTEGRATED_BUTTONS"
config.window_padding = {
    top = 30,
    bottom = 0,
    left = 5,
    right = 5
}
config.colors = {
    background = '#0c0e13',
}

-- Font
config.font = wezterm.font('JetBrains Mono', { weight = 'Medium' })
config.font_size = 12.0
config.line_height = 1.05

config.keys = {
    -- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
    {
        key = "LeftArrow",
        mods = "OPT",
        action = wezterm.action { SendString = "\x1bb" }
    },
    -- Make Option-Right equivalent to Alt-f; forward-word
    {
        key = "RightArrow",
        mods = "OPT",
        action = wezterm.action { SendString = "\x1bf" }
    },
}

-- and finally, return the configuration to wezterm
return config
