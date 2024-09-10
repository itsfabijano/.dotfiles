-- Pull in the wezterm API
local wezterm = require("wezterm")
local keys = require("keys")
local tab_bar = require("tab-bar")

-- This will hold the configuration.
local config = wezterm.config_builder()

config.enable_kitty_keyboard = true
config.enable_csi_u_key_encoding = false

config.window_decorations = "INTEGRATED_BUTTONS"
config.window_padding = {
	top = "2cell",
	bottom = 0,
	left = "1.5cell",
	right = "1.5cell",
}

local COLORS = {
	ayu_background = "#0c0e13",
	material_ocean_background = "#0f111a",
	custom_background = "#18181b",
}

config.colors = {
	background = COLORS.material_ocean_background,
}

-- Font
config.font = wezterm.font("Roboto Mono", { weight = "Medium" })
config.font_size = 12
-- config.line_height = 1.15

keys.setup(config)
tab_bar.setup(config)

-- and finally, return the configuration to wezterm
return config
