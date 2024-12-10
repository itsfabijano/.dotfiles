-- Lua
return {
	"folke/zen-mode.nvim",
	enabled = true,
	config = function()
		vim.keymap.set("n", "<leader>sb", function()
			require("zen-mode").setup({
				window = {
					width = 180,
					options = {},
				},
				plugins = {
					options = {
						enabled = true,
						ruler = false, -- disables the ruler text in the cmd line area
						showcmd = false, -- disables the command in the last line of the screen
						-- you may turn on/off statusline in zen mode by setting 'laststatus'
						-- statusline will be shown only if 'laststatus' == 3
						laststatus = 3, -- turn off the statusline in zen mode
					},
				},
			})
			require("zen-mode").toggle()
			vim.wo.wrap = false
			vim.wo.number = true
			vim.wo.rnu = true
		end)
	end,
}
