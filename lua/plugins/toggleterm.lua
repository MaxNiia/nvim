return {
	{
		"akinsho/toggleterm.nvim",
		opts = {
			size = function(term)
				if term.direction == "horizontal" then
					return 15
				elseif term.direction == "vertical" then
					return vim.o.columns * 0.4
				end
				return 20
			end,
			open_mapping = [[<f12>]],
			hide_number = true,
			autochdir = true,
			start_in_insert = true,
			terminal_mappings = true,
			persist_size = true,
			persist_mode = true,
			direction = "vertical", --| "horizontal" | "tab" | "float",
			close_on_exit = false,
			shell = vim.o.shell,
			auto_scroll = true,
			float_opts = {
				border = "curved",
				width = 120,
				height = 40,
				winblend = 3,
			},
			config = true,
			winbar = {
				enabled = false,
				name_formatter = function(term) --  term: Terminal
					return term.name
				end,
			},
		},
		config = function(_, opts)
			require("toggleterm").setup(opts)

			local wk = require("which-key")
			wk.register({
				t = {
					name = "Terminal",
					f = {
						"<cmd>ToggleTerm direction=float<CR>",
						"Float",
					},
					t = {
						"<cmd>ToggleTerm direction=vertical<CR>",
						"Vertical",
					},
					l = {
						"<cmd>ToggleTermSendCurrentLine<CR>",
						"Send line",
					},
				},
			}, {
				prefix = "<leader>",
			})
		end,
	},
}
