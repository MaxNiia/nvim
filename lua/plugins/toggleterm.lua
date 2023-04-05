return {
	{
		"akinsho/toggleterm.nvim",
		dependencies = {
			"samjwill/nvim-unception",
			init = function()
				-- Optional settings go here!
				vim.g.unception_delete_replaced_buffer = false
				vim.g.unception_open_buffer_in_new_tab = false
				vim.g.unception_enable_flavor_text = false

				vim.api.nvim_create_autocmd("User", {
					pattern = "UnceptionEditRequestReceived",
					callback = function()
						-- Toggle the terminal off.
						require("toggleterm").toggle()
					end,
				})
			end,
		},
		opts = {
			size = function(term)
				if term.direction == "horizontal" then
					return 15
				elseif term.direction == "vertical" then
					return math.max(vim.o.columns * 0.25, 80)
				end
				return 20
			end,
			on_create = function(terminal)
				terminal.name = terminal.count
			end,
			open_mapping = [[<f12>]],
			hide_number = true,
			autochdir = true,
			shade_terminals = true,
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
				l = {
						"<cmd>ToggleTermSendCurrentLine<CR>",
						"Send line",
					},
				},
			}, {
				prefix = "<leader>",
			})

			vim.cmd([[
				nnoremap <silent><f5> <Cmd>exe v:count1 . "ToggleTerm direction=float"<CR>
				nnoremap <silent><f6> <Cmd>exe v:count1 . "ToggleTerm direction=vertical"<CR>
				nnoremap <silent><f7> <Cmd>exe v:count1 . "ToggleTerm direction=horizontal"<CR>
				nnoremap <silent><f8> <Cmd> ToggleTermToggleAll <CR>
			]])
		end,
	},
}
