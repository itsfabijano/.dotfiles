-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = 'AdventureTime'

-- Tabs
config.use_fancy_tab_bar = false
config.show_tabs_in_tab_bar = true
config.show_new_tab_button_in_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false
config.enable_tab_bar = false
config.tab_bar_at_bottom = true

config.front_end = "WebGpu"

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
	local workspace = wezterm.format({
		{ Attribute = { Underline = "Single" } },
		{ Text = window:active_workspace() },
	})

	local dir = wezterm.format({
		{ Text = pane:get_current_working_dir() },
	})

	-- Make it italic and underlined
	window:set_right_status(workspace .. " | " .. dir)
end)

-- config.send_composed_key_when_left_alt_is_pressed = true
-- config.send_composed_key_when_right_alt_is_pressed = true

-- Font
config.font = wezterm.font("Roboto Mono", { weight = "Regular" })
config.font_size = 12
-- config.line_height = 1.15

-- config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

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
		key = "P",
		mods = "CMD|SHIFT",
		action = wezterm.action.ActivateCommandPalette,
	},
	{
		key = "p",
		mods = "CTRL|SHIFT",
		action = wezterm.action.Nop,
	},
	{
		key = "p",
		mods = "CMD",
		action = wezterm.action({ SendString = " pg" }),
	},
	{
		key = "b",
		mods = "CMD",
		action = wezterm.action({ SendString = " sb" }),
	},
}

-- table.insert(config.keys, {
-- 	key = "s",
-- 	mods = "LEADER",
-- 	action = wezterm.action.ShowLauncherArgs({ flags = "WORKSPACES" }),
-- })

-- and finally, return the configuration to wezterm
return config
