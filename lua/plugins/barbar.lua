return {
	{
		"romgrk/barbar.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"folke/which-key.nvim",
		},
		opts = {},
		config = function(_, opts)
			local wk = require("which_key")

			wk.register({
				[","] = {
					"cmd>BufferPrevious<CR>",
					name = "Prev Buffer",
				},
				["."] = {
					"cmd>BufferNext<CR>",
					name = "Next Buffer",
				},
				["1"] = {
					"<cmd>BufferGoto 1<CR>",
				},
				["2"] = {
					"<cmd>BufferGoto 2<CR>",
				},
				["3"] = {
					"<cmd>BufferGoto 3<CR>",
				},
				["4"] = {
					"<cmd>BufferGoto 4<CR>",
				},
				["5"] = {
					"<cmd>BufferGoto 5<CR>",
				},
				["6"] = {
					"<cmd>BufferGoto 6<CR>",
				},
				["7"] = {
					"<cmd>BufferGoto 7<CR>",
				},
				["8"] = {
					"<cmd>BufferGoto 8<CR>",
				},
				["9"] = {
					"<cmd>BufferGoto 10<CR>",
				},
				["0"] = {
					"<cmd>BufferLast<CR>",
				},
				p = {
					"<cmd>BufferPin<CR>",
					name = "Pin Buffer",
				},
				c = {
					name = "Close Buffer",
					"<cmd>BufferClose<CR>",
				},
			}, {
				prefix = "<A>",
			})

			wk.register({
				p = {
					name = "Pick Buffer",
					"<cmd>BufferPick<CR>",
				},
			}, {
				prefix = "<C>",
			})

			wk.register({
				b = {
					name = "Barbar",
					b = {
						name = "Sort by Buffer number",
						"<Cmd>BufferOrderByBufferNumber<CR>",
					},
					d = {
						name = "Sort by Directory",
						"<Cmd>BufferOrderByDirectory<CR>",
					},
					l = {
						name = "Sort by Language",
						"<Cmd>BufferOrderByLanguage<CR>",
					},
					w = {
						name = "Sort by Window number",
						"<Cmd>BufferOrderByWindowNumber<CR>",
					},
				},
			}, {
				preifx = "<leader>",
			})

			require("barbar").setup(opts)
		end,
	},
}
