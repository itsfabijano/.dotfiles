-- Pull in the wezterm API
local wezterm = require("wezterm")

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
	top = 35,
	bottom = 0,
	left = 10,
	right = 10,
}
config.colors = {
	background = "#0c0e13",
}

-- Font
config.font = wezterm.font("Roboto Mono", { weight = "Regular" })
config.font_size = 12
-- config.line_height = 1.15

config.keys = {
	-- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
	{
		key = "LeftArrow",
		mods = "OPT",
		action = wezterm.action({ SendString = "\x1bb" }),
	},
	-- Make Option-Right equivalent to Alt-f; forward-word
	{
		key = "RightArrow",
		mods = "OPT",
		action = wezterm.action({ SendString = "\x1bf" }),
	},
	{
		key = "1",
		mods = "CMD",
		action = wezterm.action({ SendString = ":lua require('harpoon.ui').nav_file(1)\r" }),
	},
	{
		key = "2",
		mods = "CMD",
		action = wezterm.action({ SendString = ":lua require('harpoon.ui').nav_file(2)\r" }),
	},
	{
		key = "3",
		mods = "CMD",
		action = wezterm.action({ SendString = ":lua require('harpoon.ui').nav_file(3)\r" }),
	},
	{
		key = "4",
		mods = "CMD",
		action = wezterm.action({ SendString = ":lua require('harpoon.ui').nav_file(4)\r" }),
	},
	{
		key = "P",
		mods = "CMD|SHIFT",
		action = wezterm.action.ActivateCommandPalette,
	},
	{
		key = "p",
		mods = "CTRL|SHIFT",
		action = wezterm.action.Nop,
	},
}

-- and finally, return the configuration to wezterm
return config
