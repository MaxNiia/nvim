return {
	{
		"ahmedkhalf/project.nvim",
		lazy = true,
		event = "VeryLazy",
		opts = {
			manual_mode = false,
			silent_chdir = false,
			scope_chdir = "tab",
		},
		config = function(_, opts)
			require("project_nvim").setup(opts)
		end,
	},
}
