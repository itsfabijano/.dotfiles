local file = require("utils.file")

local M = {}

function M.listDirs()
	local override = file.read_lines(os.getenv("HOME") .. "/.dotfiles/.profile/tmux-workspaces")
	if #override > 0 then
		return override
	end
	return { "~/repos" }
end

function M.getSelection()
	local dirs = M.listDirs()
	local workspaces = file.scandirs(dirs)
	return workspaces
end

return M
