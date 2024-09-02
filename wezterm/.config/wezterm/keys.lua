local wezterm = require("wezterm")
local act = wezterm.action
local utils = require("utils")

local keys = {}

local function disable_default_assignment(config, key, mods)
	table.insert(config.keys, {
		key = key,
		mods = mods,
		action = act.DisableDefaultAssignment,
	})
end

function keys.setup(config)
	-- https://raw.githubusercontent.com/emretuna/.dotfiles/main/wezterm/.config/wezterm/keys.lua
	config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
	config.keys = {
		-- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
		{
			key = "LeftArrow",
			mods = "OPT",
			action = act({ SendString = "\x1bb" }),
		},
		-- Make Option-Right equivalent to Alt-f; forward-word
		{
			key = "RightArrow",
			mods = "OPT",
			action = act({ SendString = "\x1bf" }),
		},
	}

	disable_default_assignment(config, "k", "CTRL|SHIFT")
	disable_default_assignment(config, "j", "CTRL|SHIFT")

	table.insert(config.keys, {
		key = "p",
		mods = "CTRL|SHIFT",
		action = act.DisableDefaultAssignment,
	})
	table.insert(config.keys, {
		key = "p",
		mods = "LEADER",
		action = act.ActivateCommandPalette,
	})

	for i = 1, 9 do
		table.insert(config.keys, {
			key = tostring(i),
			mods = "CMD",
			action = act.DisableDefaultAssignment,
		})
		table.insert(config.keys, {
			key = tostring(i),
			mods = "LEADER",
			action = act.ActivateTab(i - 1),
		})
	end

	table.insert(config.keys, {
		key = "s",
		mods = "LEADER",
		action = act.ShowLauncherArgs({ flags = "WORKSPACES" }),
	})

	table.insert(config.keys, {
		key = "f",
		mods = "LEADER",
		action = utils.actions.FuzzyFindWorkspaces(),
	})

	table.insert(config.keys, {
		key = "C",
		mods = "LEADER",
		action = utils.actions.OpenWorkspsace("~/.dotfiles"),
	})
end

return keys
