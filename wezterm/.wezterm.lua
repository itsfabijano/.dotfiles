-- Pull in the wezterm API
local wezterm = require("wezterm")
local keys = require("keys")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Tabs
config.use_fancy_tab_bar = false
config.show_tabs_in_tab_bar = true
config.show_new_tab_button_in_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false
config.enable_tab_bar = true
config.tab_bar_at_bottom = true

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
	custom_background = "#18181b",
}

config.colors = {
	background = COLORS.custom_background,
	tab_bar = {
		background = "#333333",
		active_tab = {
			bg_color = "#333333",
			fg_color = "Red",
			intensity = "Bold",
		},
		inactive_tab = {
			bg_color = "#333333",
			fg_color = "#5eacd3",
		},
	},
}

wezterm.on("update-right-status", function(window, pane)
	window:set_right_status(wezterm.format({
		{ Attribute = { Underline = "Single" } },
		{ Text = tostring(window:active_workspace()) },
		"ResetAttributes",
		{ Text = " | " },
		{ Attribute = { Italic = true } },
		{ Text = tostring(pane:get_current_working_dir()) },
	}))
end)

-- Font
config.font = wezterm.font("Roboto Mono", { weight = "Regular" })
config.font_size = 12
-- config.line_height = 1.15

keys.setup(config)

-- and finally, return the configuration to wezterm
return config
