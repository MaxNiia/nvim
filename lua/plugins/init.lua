return {
	{
		"folke/neodev.nvim",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			library = {
				enabled = true,
				runtime = true,
				types = true,
				plugins = true,
			},
			setup_jsonls = true,
			lspconfig = true,
			pathStrict = true,
			override = function(_, library)
				library.enabled = true
				library.plugins = true
			end,
		},
		config = function(_, opts)
			require("neodev").setup(opts)
		end,
	},
	{
		"NMAC427/guess-indent.nvim",
		lazy = true,
		event = "BufEnter",
		opts = {
			auto_cmd = true,
			override_editorconfig = false,
		},
	},
	{
		"windwp/nvim-spectre",
		keys = {
			{
				"<leader>rf",
				function()
					require("spectre").open()
				end,
				desc = "Replace in files (Spectre)",
			},
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
	},
	{
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
	},
	{
		"nvim-lua/plenary.nvim",
		lazy = true,
	},
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
	},
	{
		"rcarriga/nvim-notify",
		keys = {
			{
				"<leader>u",
				function()
					require("notify").dismiss({ silent = true, pending = true })
				end,
				desc = "Delete all Notifications",
			},
		},
		opts = {
			timeout = 3000,
			max_height = function()
				return math.floor(vim.o.lines * 0.25)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.5)
			end,
		},
		init = function()
			-- when noice is not enabled, install notify on VeryLazy
			vim.notify = require("notify")
		end,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		lazy = true,
		event = "BufEnter",
		config = true,
	},
	{
		"DanilaMihailov/beacon.nvim",
		lazy = true,
		event = "BufEnter",
	},
	{
		"kylechui/nvim-surround",
		lazy = true,
		event = "BufEnter",
		opts = {
			keymaps = {
				insert = "<C-g>s",
				insert_line = "<C-g>S",
				normal = "ys",
				normal_cur = "yss",
				normal_line = "yS",
				normal_cur_line = "ySS",
				visual = "S",
				visual_line = "gS",
				delete = "ds",
				change = "cs",
			},
			highlight = {
				duration = 0,
			},
			move_cursor = "begin",
		},
		config = function(_, opts)
			require("nvim-surround").setup(opts)
		end,
	},
}
