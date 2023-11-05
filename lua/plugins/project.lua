return {
	{
		"ahmedkhalf/project.nvim",
		lazy = true,
		event = "VeryLazy",
		opts = {
			manual_mode = false,
		},
		config = function(_, opts)
			require("project_nvim").setup(opts)
		end,
	},
}
