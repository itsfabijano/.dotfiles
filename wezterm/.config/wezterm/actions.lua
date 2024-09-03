local wezterm = require("wezterm")
local act = wezterm.action
local file = require("file-utils")
local workspaces = require("workspaces")

local M = {}

function M.OpenWorkspsace(
	dir --[[string]]
)
	local home = os.getenv("HOME")
	if string.find(dir, "~") then
		dir = string.gsub(dir, "~", home or "")
	end
	return act.SwitchToWorkspace({
		name = file.basename(dir),
		spawn = {
			label = "Workspace: " .. dir,
			cwd = dir,
		},
	})
end

function M.FuzzyFindWorkspaces()
	return wezterm.action_callback(function(window, pane)
		local ws = workspaces.getSelection()
		window:perform_action(
			act.InputSelector({
				action = wezterm.action_callback(function(inner_window, inner_pane, id, label)
					if not id and not label then
						wezterm.log_info("cancelled")
					else
						wezterm.log_info("id = " .. id)
						wezterm.log_info("label = " .. label)
						inner_window:perform_action(
							M.SwitchToWorkspace({
								name = file.basename(id),
								spawn = {
									label = "Workspace: " .. id,
									cwd = id,
								},
							}),
							inner_pane
						)
					end
				end),
				title = "Choose Workspace",
				choices = ws,
				fuzzy = true,
			}),
			pane
		)
	end)
end

wezterm.on("update-right-status", function(window, _)
	local active = wezterm.GLOBAL.active_workspace
	local workspace = window:active_workspace()

	if active ~= workspace then
		wezterm.GLOBAL.previous_workspace = active
		wezterm.GLOBAL.active_workspace = workspace
	end
end)

function M.PreviousWorkspace()
	return wezterm.action_callback(function(window, pane)
		local current_workspace = window:active_workspace()
		local workspace = wezterm.GLOBAL.previous_workspace

		if current_workspace == workspace or wezterm.GLOBAL.previous_workspace == nil then
			return
		end

		window:perform_action(
			act.SwitchToWorkspace({
				name = workspace,
			}),
			pane
		)
	end)
end

return M
