return {
	{
		"folke/which-key.nvim",
		keys = {
			{ "H", "^", mode = { "n", "v", "o" }, desc = "End of line" },
			{ "L", "$", mode = { "n", "v", "o" }, desc = "Start of line" },
			{ "<c-d>", "<c-d>zz>", mode = "n" },
			{ "<c-u>", "<c-u>zz", mode = "n" },
			{ "n", "nzzzv", mode = "n" },
			{ "N", "Nzzzv", mode = "n" },
			{ "<esc>", "<c-\\><c-n>", mode = "t" },
			{ "<leader>P", '"_dp', mode = "x", desc = "Paste no overwrite" },
			{
				"<leader>y",
				'"+y',
				mode = { "n", "v", "o" },
				desc = "Yank to system",
			},
			{
				"<leader>p",
				'"+p',
				mode = { "n", "v", "o" },
				desc = "Paste from system",
			},
			{
				"<leader>C",
				"<cmd>nohl<CR>",
				mode = "n",
				desc = "Clear highlighting",
			},
		},
		lazy = true,
		opts = {
			plugins = {
				registers = true,
			},
		},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)

			wk.register({
				["<leader>"] = {
					name = "Switch Window",
				},
				T = { name = "Tabs" },
				r = { name = "Refactor" },
				b = { name = "Debug" },
				h = {
					name = "Harpoon",
				},
			}, { prefix = "<leader>", mode = "n" })

			wk.register({
				c = { name = "ChatGPT" },
				t = { name = "Terminal" },
				f = {
					name = "Find",
					d = { name = "Debug" },
					g = { name = "Git" },
					w = { name = "Sessions" },
					l = { name = "LSP" },
					t = { name = "Terminal" },
				},
				x = { name = "Trouble" },
			}, { prefix = "<leader>", mode = { "n", "v" } })
		end,
	},
}
