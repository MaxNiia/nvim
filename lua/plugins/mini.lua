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
		config = function()
			require("mini.comment").setup()
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
