local default_color = "rose-pine-moon"

function ColorMyPencils(color)
	color = color or default_color
	vim.cmd.colorscheme(color)
end

return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				extend_background_behind_borders = true,
				styles = {
					italic = false,
					transparency = true,
				},
				highlight_groups = {
					NormalFloat = { bg = "#2e323b" },
					Pmenu = { bg = "#2e323b" },
					PmenuSel = { bg = "#494f5c" },
					StatusLine = { bg = "#333333" },
					DiagnosticFloatingError = { bg = "none" },
				},
			})
			ColorMyPencils()
		end,
	},
}
