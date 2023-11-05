return {
	{
		"ThePrimeagen/harpoon",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		lazy = true,
		keys = {
			{
				"<leader>Ha",
				function()
					require("harpoon.mark").add_file()
				end,
				desc = "Add file",
			},
			{
				"<leader>Hq",
				function()
					require("harpoon.ui").toggle_quick_menu()
				end,
				desc = "View marks",
			},
			{
				"<leader>Hf",
				function()
					require("harpoon.ui").nav_file(vim.v.count)
				end,
				desc = "Goto file x",
			},
			{
				"gh",
				function()
					require("harpoon.ui").nav_next()
				end,
				desc = "Next mark",
			},
			{
				"gH",
				function()
					require("harpoon.ui").nav_prev()
				end,
				desc = "Prev mark",
			},
		},
		opts = {
			tabline = false,
			tabline_prefix = "| ",
			tabline_suffix = " ",
		},
	},
}
