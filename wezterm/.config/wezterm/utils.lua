local wezterm = require("wezterm")
local act = wezterm.action

local utils = {
	file = {},
	workspaces = {},
	actions = {},
}

-- see if the file exists
function utils.file.exists(file)
	local f = io.open(file, "rb")
	if f then
		f:close()
	end
	return f ~= nil
end

-- get all lines from a file, returns an empty
-- list/table if the file does not exist
function utils.file.read_lines(file)
	if not utils.file.exists(file) then
		return {}
	end
	local lines = {}
	for line in io.lines(file) do
		lines[#lines + 1] = line
	end
	return lines
end

function utils.file.basename(str)
	local name = string.gsub(str, "(.*/)(.*)", "%2")
	return name
end

function utils.scandirs(directories)
	local t = {}
	for _, d in ipairs(directories) do
		local i, popen = 0, io.popen
		local pfile = popen("find " .. d .. " -mindepth 1 -maxdepth 1 -type d ")
		if not pfile then
			return {}
		end
		for filename in pfile:lines() do
			i = i + 1
			t[i] = { label = filename, id = filename }
		end
		pfile:close()
	end
	return t
end

function utils.workspaces.listDirs()
	local override = utils.file.read_lines("~/.dotfiles/.profile/tmux-workspaces")
	if #override > 0 then
		return override
	end
	return { "~/repos" }
end

function utils.workspaces.getSelection()
	local dirs = utils.workspaces.listDirs()
	local workspaces = utils.scandirs(dirs)
	return workspaces
end

function utils.actions.OpenWorkspsace(
	dir --[[string]]
)
	local home = os.getenv("HOME")
	if string.find(dir, "~") then
		dir = string.gsub(dir, "~", home or "")
	end
	return act.SwitchToWorkspace({
		name = utils.file.basename(dir),
		spawn = {
			label = "Workspace: " .. dir,
			cwd = dir,
		},
	})
end

function utils.actions.FuzzyFindWorkspaces()
	return wezterm.action_callback(function(window, pane)
		local workspaces = utils.workspaces.getSelection()
		window:perform_action(
			act.InputSelector({
				action = wezterm.action_callback(function(inner_window, inner_pane, id, label)
					if not id and not label then
						wezterm.log_info("cancelled")
					else
						wezterm.log_info("id = " .. id)
						wezterm.log_info("label = " .. label)
						inner_window:perform_action(
							act.SwitchToWorkspace({
								name = utils.file.basename(id),
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
				choices = workspaces,
				fuzzy = true,
			}),
			pane
		)
	end)
end

return utils
