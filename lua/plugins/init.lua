return {
	{
		"NMAC427/guess-indent.nvim",
		lazy = true,
		event = "BufEnter",
		config = true,
	},
	{
		"windwp/nvim-spectre",
		-- stylua: ignore
		keys = {
			{ "<leader>rf", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
		},
	},
	{
		"nvim-neorg/neorg",
		ft = "norg",
		config = true,
	},
	{
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
		config = true,
	},
	{

		"nvim-lua/plenary.nvim",
		lazy = true,
	},
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
		config = true,
	},
	{
		"rcarriga/nvim-notify",
		lazy = true,
		event = "BufEnter",
		config = true,
	},
	{
		"folke/todo-comments.nvim",
		lazy = true,
		event = "BufEnter",
		config = true,
	},
	{
		"tpope/vim-repeat",
		lazy = true,
		event = "BufEnter",
	},
	{
		"ggandor/flit.nvim",
		dependencies = {

			"ggandor/leap.nvim",
		},
		lazy = true,
		event = "BufEnter",
		config = true,
	},
	{
		"ggandor/leap.nvim",
		lazy = true,
		event = "BufEnter",
		config = function(_, _)
			require("leap").add_default_mappings()
		end,
	},
	{
		"DanilaMihailov/beacon.nvim",
		lazy = true,
		event = "BufEnter",
	},
}
