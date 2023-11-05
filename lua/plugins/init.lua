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
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		keys = {
			{ "<c-p>", "<Cmd>BufferLinePick<CR>", desc = "Pick buffer" },
			{ "<a-p>", "<Cmd>BufferLinePickClose<CR>", desc = "Close buffer" },
			{ "<a-0>", "<Cmd>BufferLineGoToBuffer -1<CR>", desc = "Last buffer" },
			{ "<a-1>", "<Cmd>BufferLineGoToBuffer 1<CR>", desc = "1 buffer" },
			{ "<a-2>", "<Cmd>BufferLineGoToBuffer 2<CR>", desc = "2 buffer" },
			{ "<a-3>", "<Cmd>BufferLineGoToBuffer 3<CR>", desc = "3 buffer" },
			{ "<a-4>", "<Cmd>BufferLineGoToBuffer 4<CR>", desc = "4 buffer" },
			{ "<a-5>", "<Cmd>BufferLineGoToBuffer 5<CR>", desc = "5 buffer" },
			{ "<a-6>", "<Cmd>BufferLineGoToBuffer 6<CR>", desc = "6 buffer" },
			{ "<a-7>", "<Cmd>BufferLineGoToBuffer 7<CR>", desc = "7 buffer" },
			{ "<a-8>", "<Cmd>BufferLineGoToBuffer 8<CR>", desc = "8 buffer" },
			{ "<a-9>", "<Cmd>BufferLineGoToBuffer 9<CR>", desc = "9 buffer" },
			{ "<a-,>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev buffer" },
			{ "<a-.>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
			{ "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
			{ "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
		},
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
			vim.notify = require("notify")
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
