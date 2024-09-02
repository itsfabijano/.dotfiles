local set = vim.keymap.set

return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	-- or                              , branch = '0.1.x',
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"nvim-telescope/telescope-ui-select.nvim",
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

		set("n", "<leader>pb", builtin.buffers, {}) -- [P]roject [B]uffers
		set("n", "<D-p>", builtin.git_files, {})
		set("n", "<leader>pf", builtin.find_files, {}) -- [P]roject [F]ilesearch
		set("n", "<leader>pg", builtin.git_files, {}) -- [P]roject [G]itsearch
		set("n", "<leader>/", builtin.current_buffer_fuzzy_find)

		set("n", "<leader>pws", function() -- [P]roject [W]ord [S]earch
			local word = vim.fn.expand("<cword>")
			builtin.grep_string({ search = word })
		end)
		set("n", "<leader>pWs", function() -- [P]roject [W]ord [S]earch
			local word = vim.fn.expand("<cWORD>")
			builtin.grep_string({ search = word })
		end)
		set("n", "<leader>ps", function() -- [P]roject [S]earch
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end)

		set("n", "<leader>vh", builtin.help_tags, {}) -- [V]iew [H]elp

		-- [P]roject [C]ommands
		set("n", "<leader>pc", builtin.commands, {})
	end,
}
