return {
	{
		"stevearc/aerial.nvim",
		lazy = true,
		event = "BufEnter",
		dependencies = {
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
			"folke/which-key.nvim",
		},
		opts = {
			on_attach = function(bufnr)
				local wk = require("which-key")
				wk.register({
					A = {
						name = "+Aerial",
						["["] = {
							"<cmd>AerialPrev<CR>",
							"Previous Aerial",
						},
						["]"] = {
							"<cmd>AerialNext<CR>",
							"Next Aerial",
						},
						A = {
							"<cmd>AerialToggle!<CR>",
							"Toggle Aerial",
						},
					},
				}, {
					prefix = "<leader>",
					buffer = bufnr,
				})
			end,
			buftype_exclude = {
				"nofile",
				"terminal",
			},
			char = "▏",
			context_char = "▏",
			show_current_context = true,
			use_treesitter = true,
			filetype_exclude = {
				"help",
				"startify",
				"aerial",
				"alpha",
				"dashboard",
				"lazy",
				"neogitstatus",
				"NvimTree",
				"neo-tree",
				"Trouble",
			},
		},
		config = true,
	},
}
