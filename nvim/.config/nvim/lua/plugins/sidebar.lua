local function harpoon_section()
	local harpoon = require("harpoon")

	return {
		title = "Harpoon Hooks",
		icon = "📍",
		setup = function()
			-- called only once and if the section is being used
		end,
		update = function()
			-- hook callback, called when an update was requested by either the user of external events (using autocommands)
		end,
		draw = function()
			local items = harpoon:list().items
			local harpoon_marks = {}
			local function generate_lines()
				harpoon_marks = {}
				for i, item in ipairs(items) do
					table.insert(harpoon_marks, string.format("[%d] %s", i, item.value))
				end
			end
			generate_lines()

			return table.concat(harpoon_marks, "\n")
		end,
	}
end

local function get_branch_name()
	for line in io.popen("git branch 2>nul"):lines() do
		local m = line:match("%* (.+)$")
		if m then
			return m
		end
	end

	return false
end

local function project_name()
	local cwd = vim.fn.getcwd()
	local name = cwd:match("([^/]+)$")
	local branch = get_branch_name()
	return {
		title = "Project",
		draw = function()
			return name .. (branch and " (" .. branch .. ")" or "")
		end,
	}
end

return {
	"sidebar-nvim/sidebar.nvim",
	enabled = true,
	config = function()
		local sidebar = require("sidebar-nvim")
		sidebar.setup({
			sections = { project_name(), harpoon_section() },
			initial_width = 100,
			open = true,
			disable_default_keybindings = false,
			todos = {
				initially_closed = true,
			},
		})

		vim.keymap.set("n", "<leader>sb", sidebar.toggle)
	end,
}
