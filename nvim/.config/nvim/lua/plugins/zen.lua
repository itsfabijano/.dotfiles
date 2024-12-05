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
			})
			require("zen-mode").toggle()
			vim.wo.wrap = false
			vim.wo.number = true
			vim.wo.rnu = true
		end)
	end,
}
