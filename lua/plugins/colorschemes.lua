return {
	{
		"catppuccin/nvim",
		dependencies = {
			"nvim-lualine/lualine.nvim",
		},
		lazy = true,
		name = "catppuccin",
		config = function(_, _)
			require("theme.catppuccin")
		end,
	},
	{
		"EdenEast/nightfox.nvim",
		dependencies = {
			"nvim-lualine/lualine.nvim",
		},
		lazy = true,
		name = "nightfox",
		config = function(_, _)
			require("theme.nightfox")
		end,
	},
}
