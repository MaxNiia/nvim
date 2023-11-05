return {
	{
		"imNel/monorepo.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{
				"<leader>m",
				function()
					require("monorepo").toggle_project()
				end,
				desc = "Toggle in project",
				mode = "n",
			},
			{
				"gp",
				function()
					require("monorepo").next_project()
				end,
				desc = "Next Project",
				mode = "n",
			},
			{
				"gP",
				function()
					require("monorepo").previous_project()
				end,
				desc = "Previous Project",
				mode = "n",
			},
		},
		opts = {
			silent = false,
			autoload_telescope = true,
			data_path = vim.fn.stdpath("data"),
		},
	},
}
