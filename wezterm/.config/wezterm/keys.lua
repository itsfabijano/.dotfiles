local wezterm = require("wezterm")
local act = wezterm.action
local actions = require("actions")

local M = {}

local function KeyBuilder(config)
	local function unset(key, mods)
		table.insert(config.keys, {
			key = key,
			mods = mods,
			action = act.DisableDefaultAssignment,
		})
	end

	local function set(key, mods, action)
		table.insert(config.keys, {
			key = key,
			mods = mods,
			action = action,
		})
	end

	return {
		unset = unset,
		set = set,
	}
end

function M.setup(config)
	local b = KeyBuilder(config)
	-- https://raw.githubusercontent.com/emretuna/.dotfiles/main/wezterm/.config/wezterm/keys.lua
	config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
	config.keys = {}

	-- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
	b.set("LeftArrow", "OPT", act.SendString("\x1bb"))
	-- Make Option-Right equivalent to Alt-f; forward-word
	b.set("RightArrow", "OPT", act.SendString("\x1bf"))

	b.unset("k", "CTRL|SHIFT")
	b.unset("j", "CTRL|SHIFT")
	b.unset("p", "CTRL|SHIFT")
	b.set("p", "LEADER", act.ActivateCommandPalette)

	for i = 1, 9 do
		b.unset(tostring(i), "CMD")
		b.set(tostring(i), "LEADER", act.ActivateTab(i - 1))
	end

	b.set("s", "LEADER", act.ShowLauncherArgs({ flags = "WORKSPACES" }))
	b.set("f", "LEADER", actions.FuzzyFindWorkspaces())
	b.set("C", "LEADER", actions.OpenWorkspsace("~/.dotfiles"))
	b.set("L", "LEADER", actions.PreviousWorkspace())

	b.unset("t", "CMD")
	b.set("c", "LEADER", act.SpawnTab("CurrentPaneDomain"))

	-- TODO: Add more keybindings here
	-- <Prefix> & for killing a window
	-- <Prefix> x for killing a pane
end

return M
