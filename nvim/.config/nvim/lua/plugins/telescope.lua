-- plugins/telescope.lua:
return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	-- or                              , branch = '0.1.x',
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
	},

	config = function()
		require("telescope").setup({
			pickers = {
				find_files = {
					hidden = true,
					no_ignore = true,
				},
				git_files = {
					hidden = true,
				},
			},
			defaults = {
				file_ignore_patterns = { "yarn.lock", "node_modules/*", "**/.git/*" },
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
		})

		-- Enable Telescope extensions if they are installed
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")

		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
		vim.keymap.set("n", "<leader>pg", builtin.git_files, {})
		vim.keymap.set("n", "<D-p>", builtin.git_files, {})

		-- vim.api.nvim_create_user_command("CustomFindFiles", function()
		-- 	pcall(function()
		-- 		builtin.git_files()
		-- 	end)
		-- end, {})

		vim.keymap.set("n", "<leader>pws", function()
			local word = vim.fn.expand("<cword>")
			builtin.grep_string({ search = word })
		end)
		vim.keymap.set("n", "<leader>pWs", function()
			local word = vim.fn.expand("<cWORD>")
			builtin.grep_string({ search = word })
		end)
		vim.keymap.set("n", "<leader>ps", function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end)
		-- [V]iew [H]elp
		vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})

		-- [P]roject [C]ommands
		vim.keymap.set("n", "<leader>pc", builtin.commands, {})
	end,
}
