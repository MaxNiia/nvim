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
		},
		config = true,
	},
}
