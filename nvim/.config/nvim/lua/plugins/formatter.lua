return {
	"stevearc/conform.nvim",
	opts = {},
	dependencies = { "WhoIsSethDaniel/mason-tool-installer.nvim" },
	config = function()
		local conform = require("conform")
		local mason_tools = require("mason-tool-installer")

		mason_tools.setup({
			ensure_installed = {
				"prettier",
				"stylua",
				"black",
			},
		})

		conform.setup({
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				json = { "prettier" },
				lua = { "stylua" },
				graphql = { "prettier" },
				python = { "black" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 5000,
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			})
		end)
	end,
}
