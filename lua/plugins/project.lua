return {
	{
		"ahmedkhalf/project.nvim",
		dependencies = {
			"nvim-tree/nvim-tree.lua",
		},
		lazy = true,
		opts = {
			manual_mode = false,
		},
		config = function(_, opts)
			require("project_nvim").setup(opts)
		end,
	},
}
