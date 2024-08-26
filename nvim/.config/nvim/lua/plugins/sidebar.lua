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
			local marks = harpoon.get_mark_config().marks
			local harpoon_marks = {}

			local function generate_lines()
				harpoon_marks = {}
				for i, mark in pairs(marks) do
					table.insert(harpoon_marks, string.format("[%d] %s", i, mark.filename))
				end
			end
			generate_lines()

			return table.concat(harpoon_marks, "\n")
		end,
	}
end

local function project_name()
	local cwd = vim.fn.getcwd()
	local name = cwd:match("([^/]+)$")
	return {
		title = "Project",
		draw = function()
			return name
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
