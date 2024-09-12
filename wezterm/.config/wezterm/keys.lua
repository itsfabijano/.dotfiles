local wezterm = require("wezterm")
local wez_actions = wezterm.action
local actions = require("actions")

local M = {}

local function KeyBuilder(config)
	local function unset(key, mods)
		table.insert(config.keys, {
			key = key,
			mods = mods,
			action = wez_actions.DisableDefaultAssignment,
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
	b.set("LeftArrow", "OPT", wez_actions.SendString("\x1bb"))
	-- Make Option-Right equivalent to Alt-f; forward-word
	b.set("RightArrow", "OPT", wez_actions.SendString("\x1bf"))

	b.unset("k", "CTRL|SHIFT")
	b.unset("j", "CTRL|SHIFT")
	b.unset("p", "CTRL|SHIFT")
	b.set("p", "LEADER", wez_actions.ActivateCommandPalette)

	for i = 1, 9 do
		b.unset(tostring(i), "CMD")
		b.set(tostring(i), "LEADER", wez_actions.ActivateTab(i - 1))
	end

	b.set("s", "LEADER", wez_actions.ShowLauncherArgs({ flags = "WORKSPACES" }))
	b.set("f", "LEADER", actions.FuzzyFindWorkspaces())
	b.set("C", "LEADER", actions.OpenWorkspsace("~/.dotfiles"))
	b.set("L", "LEADER", actions.PreviousWorkspace())

	b.unset("t", "CMD")
	b.set("c", "LEADER", wez_actions.SpawnTab("CurrentPaneDomain"))
	b.set(",", "LEADER|CTRL", wez_actions.MoveTabRelative(-1)) -- <
	b.set(".", "LEADER|CTRL", wez_actions.MoveTabRelative(1)) -- >

	b.unset("w", "CMD")
	b.set("&", "LEADER", wez_actions.CloseCurrentTab({ confirm = true }))
	b.set("x", "LEADER", wez_actions.CloseCurrentPane({ confirm = false }))

	-- TODO: Add more keybindings here
	-- <Prefix> : for custom command palette
	-- <Prefix> ( ) for moving to next and previous workspace
	-- <Prefix> n p for moving to next and previous tab
	-- <Prefix> hjkl to move between panes
end

return M
