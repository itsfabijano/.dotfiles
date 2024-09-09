return {
	"theprimeagen/harpoon",
	branch = "harpoon2",
	enabled = true,
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")

		harpoon:setup()

		vim.keymap.set("n", "<leader>a", function()
			harpoon:list():add()
		end)
		vim.keymap.set("n", "<C-e>", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)

		vim.keymap.set("n", "<D-1>", function()
			harpoon:list():select(1)
		end)
		vim.keymap.set("n", "<D-2>", function()
			harpoon:list():select(2)
		end)
		vim.keymap.set("n", "<D-3>", function()
			harpoon:list():select(3)
		end)
		vim.keymap.set("n", "<D-4>", function()
			harpoon:list():select(4)
		end)

		vim.keymap.set("n", "<leader><D-1>", function()
			harpoon:list():replace_at(1)
		end)
		vim.keymap.set("n", "<leader><D-2>", function()
			harpoon:list():replace_at(2)
		end)
		vim.keymap.set("n", "<leader><D-3>", function()
			harpoon:list():replace_at(3)
		end)
		vim.keymap.set("n", "<leader><D-4>", function()
			harpoon:list():replace_at(4)
		end)
	end,
}
