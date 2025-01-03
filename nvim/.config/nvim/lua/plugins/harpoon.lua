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

		vim.keymap.set("n", "<C-1>", function()
			harpoon:list():select(1)
		end)
		vim.keymap.set("n", "<C-2>", function()
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

		local custom_sequence = "<ESC>Cmd"
		vim.keymap.set("n", custom_sequence .. "1", function()
			harpoon:list():select(1)
		end)
		vim.keymap.set("n", custom_sequence .. "2", function()
			harpoon:list():select(2)
		end)
		vim.keymap.set("n", custom_sequence .. "3", function()
			harpoon:list():select(3)
		end)
		vim.keymap.set("n", custom_sequence .. "4", function()
			harpoon:list():select(4)
		end)

		vim.keymap.set("n", "<leader>h1", function()
			harpoon:list():replace_at(1)
		end)
		vim.keymap.set("n", "<leader>h2", function()
			harpoon:list():replace_at(2)
		end)
		vim.keymap.set("n", "<leader>h3", function()
			harpoon:list():replace_at(3)
		end)
		vim.keymap.set("n", "<leader>h4", function()
			harpoon:list():replace_at(4)
		end)
	end,
}
