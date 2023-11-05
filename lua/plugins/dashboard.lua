return {
	{
		"glepnir/dashboard-nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"ahmedkhalf/project.nvim",
			"olimorris/persisted.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		event = "VimEnter",
		opts = {
			config = {
				week_header = {
					enable = true,
				},
				shortcut = {
					{
						desc = "Files",
						group = "Label",
						action = "Telescope find_files",
						key = "f",
					},
					{
						desc = "Projects",
						group = "Label",
						action = "Telescope projects",
						key = "p",
					},
					{
						desc = "Sessions",
						group = "Label",
						action = "Telescope persisted",
						key = "s",
					},
				},
			},
		},
	},
}
