local default_color = "rose-pine-moon"

function ColorMyPencils(color)
	color = color or default_color
	vim.cmd.colorscheme(color)

	-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#2e323b" })
	-- vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })

	-- Set the background color of the popup menu without changing the text color
	vim.cmd([[highlight Pmenu guibg=#2e323b]])

	-- Set the background color of the selected item in the popup menu
	vim.cmd([[highlight PmenuSel guibg=#61AFEF]])
	vim.cmd([[highlight StatusLine guibg=#333333]])
end

return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				disable_background = true,
				styles = {
					italic = false,
					transparency = true,
				},
			})
			ColorMyPencils()
		end,
	},
	{
		"Shatur/neovim-ayu",
		name = "ayu",
		config = function()
			require("ayu").setup({
				mirage = false,
				overrides = {
					Normal = { bg = "None" },
					ColorColumn = { bg = "#24262a" },
					SignColumn = { bg = "None" },
					Folded = { bg = "None" },
					FoldColumn = { bg = "None" },
					CursorLine = { bg = "#1b1c1f" },
					CursorColumn = { bg = "None" },
					WhichKeyFloat = { bg = "None" },
					VertSplit = { bg = "None" },
				},
			})
			ColorMyPencils()
		end,
	},
}
