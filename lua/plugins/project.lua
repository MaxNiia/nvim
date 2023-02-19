return {
	{
		"ahmedkhalf/project.nvim",
		lazy = true,
		opts = {
			manual_mode = false,
		},
		config = function(_, opts)
			require("project_nvim").setup(opts)
		end,
	},
}
