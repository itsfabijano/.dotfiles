local wezterm = require("wezterm")
local actions = require("actions")

local M = {}

local function create_key_setter(config)
	return function(mods, key, action)
		table.insert(config.keys, {
			key = key,
			mods = mods,
			action = action,
		})
	end
end

function M.setup(config)
	config.disable_default_key_bindings = true

	-- https://raw.githubusercontent.com/emretuna/.dotfiles/main/wezterm/.config/wezterm/keys.lua
	config.keys = {}
	local set = create_key_setter(config)

	local LEADER = "a"
	config.leader = { key = LEADER, mods = "CTRL", timeout_milliseconds = 1000 }
	set("LEADER|CTRL", LEADER, wezterm.action.SendKey({ key = LEADER, mods = "CTRL" }))

	-- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
	set("OPT", "LeftArrow", wezterm.action.SendString("\x1bb"))
	-- Make Option-Right equivalent to Alt-f; forward-word
	set("OPT", "RightArrow", wezterm.action.SendString("\x1bf"))

	set("LEADER", "p", wezterm.action.ActivateCommandPalette)

	for i = 1, 9 do
		set("LEADER", tostring(i), wezterm.action.ActivateTab(i - 1))
	end

	set("LEADER", "s", wezterm.action.ShowLauncherArgs({ flags = "WORKSPACES" }))
	set("LEADER", "f", actions.FuzzyFindWorkspaces())
	set("LEADER", "C", actions.OpenWorkspsace("~/.dotfiles"))
	set("LEADER", "L", actions.PreviousWorkspace())

	set("LEADER", "c", wezterm.action.SpawnTab("CurrentPaneDomain"))
	set("LEADER|CTRL", ",", wezterm.action.MoveTabRelative(-1)) -- <
	set("LEADER|CTRL", ".", wezterm.action.MoveTabRelative(1)) -- >

	set("LEADER", "&", wezterm.action.CloseCurrentTab({ confirm = true }))
	set("LEADER", "x", wezterm.action.CloseCurrentPane({ confirm = false }))
	set("LEADER", "d", wezterm.action.ShowDebugOverlay)

	set("SUPER", "c", wezterm.action.CopyTo("Clipboard"))
	set("SUPER", "v", wezterm.action.PasteFrom("Clipboard"))

	set("SUPER", "-", wezterm.action.DecreaseFontSize)
	set("SUPER", "+", wezterm.action.IncreaseFontSize)
	set("SUPER", "0", wezterm.action.ResetFontSize)

	set("LEADER", "[", wezterm.action.ActivateCopyMode)
	set("LEADER", "]", wezterm.action.QuickSelect)
	set("LEADER", "/", wezterm.action.Search({ CaseInSensitiveString = "" }))

	set("LEADER", '"', wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }))
	set("LEADER", "%", wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }))
	set("LEADER", "h", wezterm.action.ActivatePaneDirection("Left"))
	set("LEADER", "l", wezterm.action.ActivatePaneDirection("Right"))
	set("LEADER", "j", wezterm.action.ActivatePaneDirection("Down"))
	set("LEADER", "k", wezterm.action.ActivatePaneDirection("Up"))
	set("LEADER|CTRL", "LeftArrow", wezterm.action.AdjustPaneSize({ "Left", 40 }))
	set("LEADER|CTRL", "RightArrow", wezterm.action.AdjustPaneSize({ "Right", 40 }))
	set("LEADER|CTRL", "DownArrow", wezterm.action.AdjustPaneSize({ "Down", 40 }))
	set("LEADER|CTRL", "UpArrow", wezterm.action.AdjustPaneSize({ "Up", 40 }))
	set("LEADER", "Enter", wezterm.action.PaneSelect({ mode = "SwapWithActive" }))
	set("LEADER", "{", wezterm.action.RotatePanes("CounterClockwise"))
	set("LEADER", "}", wezterm.action.RotatePanes("Clockwise"))
	set("LEADER", "b", wezterm.action.TogglePaneZoomState)
	set("SUPER", "q", wezterm.action.QuitApplication)

	set(
		"SUPER",
		"k",
		wezterm.action.Multiple({
			wezterm.action.ClearScrollback("ScrollbackAndViewport"),
			wezterm.action.SendKey({ key = "L", mods = "CTRL" }),
		})
	)

	config.key_tables = {
		copy_mode = {
			{ key = "Tab", mods = "NONE", action = wezterm.action.CopyMode("MoveForwardWord") },
			{ key = "Tab", mods = "SHIFT", action = wezterm.action.CopyMode("MoveBackwardWord") },
			{ key = "Enter", mods = "NONE", action = wezterm.action.CopyMode("MoveToStartOfNextLine") },
			{ key = "Escape", mods = "NONE", action = wezterm.action.CopyMode("Close") },
			{ key = "Space", mods = "NONE", action = wezterm.action.CopyMode({ SetSelectionMode = "Cell" }) },
			{ key = "$", mods = "NONE", action = wezterm.action.CopyMode("MoveToEndOfLineContent") },
			{ key = "$", mods = "SHIFT", action = wezterm.action.CopyMode("MoveToEndOfLineContent") },
			{ key = ",", mods = "NONE", action = wezterm.action.CopyMode("JumpReverse") },
			{ key = "0", mods = "NONE", action = wezterm.action.CopyMode("MoveToStartOfLine") },
			{ key = ";", mods = "NONE", action = wezterm.action.CopyMode("JumpAgain") },
			{ key = "F", mods = "NONE", action = wezterm.action.CopyMode({ JumpBackward = { prev_char = false } }) },
			{ key = "F", mods = "SHIFT", action = wezterm.action.CopyMode({ JumpBackward = { prev_char = false } }) },
			{ key = "G", mods = "NONE", action = wezterm.action.CopyMode("MoveToScrollbackBottom") },
			{ key = "G", mods = "SHIFT", action = wezterm.action.CopyMode("MoveToScrollbackBottom") },
			{ key = "H", mods = "NONE", action = wezterm.action.CopyMode("MoveToViewportTop") },
			{ key = "H", mods = "SHIFT", action = wezterm.action.CopyMode("MoveToViewportTop") },
			{ key = "L", mods = "NONE", action = wezterm.action.CopyMode("MoveToViewportBottom") },
			{ key = "L", mods = "SHIFT", action = wezterm.action.CopyMode("MoveToViewportBottom") },
			{ key = "M", mods = "NONE", action = wezterm.action.CopyMode("MoveToViewportMiddle") },
			{ key = "M", mods = "SHIFT", action = wezterm.action.CopyMode("MoveToViewportMiddle") },
			{ key = "O", mods = "NONE", action = wezterm.action.CopyMode("MoveToSelectionOtherEndHoriz") },
			{ key = "O", mods = "SHIFT", action = wezterm.action.CopyMode("MoveToSelectionOtherEndHoriz") },
			{ key = "T", mods = "NONE", action = wezterm.action.CopyMode({ JumpBackward = { prev_char = true } }) },
			{ key = "T", mods = "SHIFT", action = wezterm.action.CopyMode({ JumpBackward = { prev_char = true } }) },
			{ key = "V", mods = "NONE", action = wezterm.action.CopyMode({ SetSelectionMode = "Line" }) },
			{ key = "V", mods = "SHIFT", action = wezterm.action.CopyMode({ SetSelectionMode = "Line" }) },
			{ key = "^", mods = "NONE", action = wezterm.action.CopyMode("MoveToStartOfLineContent") },
			{ key = "^", mods = "SHIFT", action = wezterm.action.CopyMode("MoveToStartOfLineContent") },
			{ key = "b", mods = "NONE", action = wezterm.action.CopyMode("MoveBackwardWord") },
			{ key = "b", mods = "ALT", action = wezterm.action.CopyMode("MoveBackwardWord") },
			{ key = "b", mods = "CTRL", action = wezterm.action.CopyMode("PageUp") },
			{ key = "c", mods = "CTRL", action = wezterm.action.CopyMode("Close") },
			{ key = "d", mods = "CTRL", action = wezterm.action.CopyMode({ MoveByPage = 0.5 }) },
			{ key = "e", mods = "NONE", action = wezterm.action.CopyMode("MoveForwardWordEnd") },
			{ key = "f", mods = "NONE", action = wezterm.action.CopyMode({ JumpForward = { prev_char = false } }) },
			{ key = "f", mods = "ALT", action = wezterm.action.CopyMode("MoveForwardWord") },
			{ key = "f", mods = "CTRL", action = wezterm.action.CopyMode("PageDown") },
			{ key = "g", mods = "NONE", action = wezterm.action.CopyMode("MoveToScrollbackTop") },
			{ key = "g", mods = "CTRL", action = wezterm.action.CopyMode("Close") },
			{ key = "h", mods = "NONE", action = wezterm.action.CopyMode("MoveLeft") },
			{ key = "j", mods = "NONE", action = wezterm.action.CopyMode("MoveDown") },
			{ key = "k", mods = "NONE", action = wezterm.action.CopyMode("MoveUp") },
			{ key = "l", mods = "NONE", action = wezterm.action.CopyMode("MoveRight") },
			{ key = "m", mods = "ALT", action = wezterm.action.CopyMode("MoveToStartOfLineContent") },
			{ key = "o", mods = "NONE", action = wezterm.action.CopyMode("MoveToSelectionOtherEnd") },
			{ key = "q", mods = "NONE", action = wezterm.action.CopyMode("Close") },
			{ key = "t", mods = "NONE", action = wezterm.action.CopyMode({ JumpForward = { prev_char = true } }) },
			{ key = "u", mods = "CTRL", action = wezterm.action.CopyMode({ MoveByPage = -0.5 }) },
			{ key = "v", mods = "NONE", action = wezterm.action.CopyMode({ SetSelectionMode = "Cell" }) },
			{ key = "v", mods = "CTRL", action = wezterm.action.CopyMode({ SetSelectionMode = "Block" }) },
			{ key = "w", mods = "NONE", action = wezterm.action.CopyMode("MoveForwardWord") },
			{
				key = "y",
				mods = "NONE",
				action = wezterm.action.Multiple({
					{ CopyTo = "ClipboardAndPrimarySelection" },
					{ CopyMode = "Close" },
				}),
			},
			{ key = "PageUp", mods = "NONE", action = wezterm.action.CopyMode("PageUp") },
			{ key = "PageDown", mods = "NONE", action = wezterm.action.CopyMode("PageDown") },
			{ key = "End", mods = "NONE", action = wezterm.action.CopyMode("MoveToEndOfLineContent") },
			{ key = "Home", mods = "NONE", action = wezterm.action.CopyMode("MoveToStartOfLine") },
			{ key = "LeftArrow", mods = "NONE", action = wezterm.action.CopyMode("MoveLeft") },
			{ key = "LeftArrow", mods = "ALT", action = wezterm.action.CopyMode("MoveBackwardWord") },
			{ key = "RightArrow", mods = "NONE", action = wezterm.action.CopyMode("MoveRight") },
			{ key = "RightArrow", mods = "ALT", action = wezterm.action.CopyMode("MoveForwardWord") },
			{ key = "UpArrow", mods = "NONE", action = wezterm.action.CopyMode("MoveUp") },
			{ key = "DownArrow", mods = "NONE", action = wezterm.action.CopyMode("MoveDown") },
		},
		search_mode = {
			{ key = "Enter", mods = "NONE", action = wezterm.action.ActivateCopyMode },
			{ key = "Escape", mods = "NONE", action = wezterm.action.CopyMode("Close") },
			{ key = "n", mods = "CTRL", action = wezterm.action.CopyMode("NextMatch") },
			{ key = "p", mods = "CTRL", action = wezterm.action.CopyMode("PriorMatch") },
			{ key = "r", mods = "CTRL", action = wezterm.action.CopyMode("CycleMatchType") },
			{ key = "u", mods = "CTRL", action = wezterm.action.CopyMode("ClearPattern") },
		},
	}

	-- TODO: Add more keybindings here
	-- <Prefix> : for custom command palette
	-- <Prefix> ( ) for moving to next and previous workspace
	-- <Prefix> n p for moving to next and previous tab
end

return M
