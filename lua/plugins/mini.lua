return {
	{
		"echasnovski/mini.ai",
		version = false,
		event = "BufEnter",
		config = function()
			require("mini.ai").setup()
		end,
	},
	{
		"echasnovski/mini.bracketed",
		version = false,
		event = "BufEnter",
		config = function()
			require("mini.bracketed").setup()
		end,
	},
	{
		"echasnovski/mini.comment",
		version = false,
		event = "BufEnter",
		opts = {
			options = {
				custom_commentstring = nil,
				ignore_blank_line = true,
			},
		},
		config = function(_, opts)
			require("mini.comment").setup(opts)
		end,
	},
	{
		"echasnovski/mini.cursorword",
		version = false,
		event = "BufEnter",
		config = function()
			require("mini.cursorword").setup()
		end,
	},
	{
		"echasnovski/mini.jump",
		version = false,
		event = "BufEnter",
		config = function()
			require("mini.jump").setup()
		end,
	},
	{
		"echasnovski/mini.jump2d",
		version = false,
		event = "BufEnter",
		config = function()
			require("mini.jump2d").setup()
		end,
	},
}
