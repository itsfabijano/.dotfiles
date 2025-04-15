return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		lazygit = {
			enable = true,
		},
	},
	keys = {
		{
			"<leader>gs",
			function()
				Snacks.lazygit()
			end,
			desc = "Lazygit",
		},
	},
}
