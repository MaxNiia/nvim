return {
	{
		"folke/trouble.nvim",
		event = "BufEnter",
		opts = {
			auto_close = true,
			position = "bottom",
			icons = true,
			use_diagnostic_signs = true,
		},
	},
}
