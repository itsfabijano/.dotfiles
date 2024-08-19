local default_color = "ayu"

function ColorMyPencils(color)
    color = color or default_color
    vim.cmd.colorscheme(color)

    --vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    --vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    --vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
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
                    CursorLine = { bg = "None" },
                    CursorColumn = { bg = "None" },
                    WhichKeyFloat = { bg = "None" },
                    VertSplit = { bg = "None" },
                },
            })
            ColorMyPencils()
        end,
    },
}
