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
		"stevearc/dressing.nvim",
		lazy = true,
		init = function()
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
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
		keys = {
			{
				"<leader>un",
				function()
					require("notify").dismiss({ silent = true, pending = true })
				end,
				desc = "Delete all Notifications",
			},
		},
		opts = {
			timeout = 3000,
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
		},
		init = function()
			-- when noice is not enabled, install notify on VeryLazy
			local Util = require("lazyvim.util")
			if not Util.has("noice.nvim") then
				Util.on_very_lazy(function()
					vim.notify = require("notify")
				end)
			end
		end,
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
