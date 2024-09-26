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
	grey = "#1e2127",
	dark_red = "#0a0000",
	github_dark = "#0d1117",
}

config.colors = {
	background = COLORS.grey,
}

-- config.freetype_load_target = "Light"

-- Font
config.font = wezterm.font("RobotoMono Nerd Font", { weight = "Regular" })
-- config.font = wezterm.font("Hack Nerd Font", { weight = "Regular" })
-- config.font = wezterm.font("MesloLGL Nerd Font", { weight = "Regular" })
config.font_size = 12

config.inactive_pane_hsb = {
	saturation = 0.9,
	brightness = 0.8,
}

config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
-- config.line_height = 1.1
-- config.cell_width = 1

keys.setup(config)
tab_bar.setup(config)

-- and finally, return the configuration to wezterm
return config
