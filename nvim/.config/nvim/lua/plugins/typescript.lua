return {
	"pmizio/typescript-tools.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	event = "VeryLazy",
	opts = {},
	config = function()
		require("typescript-tools").setup({
			tsserver_file_preferences = {
				-- "shortest" | "project-relative" | "relative" | "non-relative"
				importModuleSpecifierPreference = "shortest",
			},
		})
	end,
}
