return {
	{
		"voldikss/vim-floaterm",
		dependencies = {
			"folke/which-key.nvim",
		},
		lazy = true,
		event = "BufEnter",
		config = function(_, _)
			local wk = require("which-key")

			wk.register({
				["<f7>"] = {
					"<cmd>FloatermPrev<CR>",
					"Prev Terminal",
				},
				["<f8>"] = {
					"<cmd>FloatermNext<CR>",
					"Next Terminal",
				},
				["<f9>"] = {
					"<cmd>FloatermNew<CR>",
					"New Terminal",
				},
				["<f12>"] = {
					"<cmd>FloatermToggle<CR>",
					"Toggle Terminal",
				},
			}, {
				mode = "n",
			})

			wk.register({
				["<f7>"] = {
					"<C-\\><C-n><cmd>FloatermPrev<CR>",
					"Prev Terminal",
				},
				["<f8>"] = {
					"<C-\\><C-n><cmd>FloatermNext<CR>",
					"Next Terminal",
				},
				["<f9>"] = {
					"<C-\\><C-n><cmd>FloatermNew<CR>",
					"New Terminal",
				},
				["<f10>"] = {
					"<C-\\><C-n><cmd>FloatermKill<CR>",
					"Kill Terminal",
				},
				["<f12>"] = {
					"<C-\\><C-n><cmd>FloatermToggle<CR>",
					"Toggle Terminal",
				},
			}, {
				mode = "t",
			})
			local set = vim.g

			set.floaterm_width = 0.6
			set.floaterm_height = 0.95
		end,
	},
}
