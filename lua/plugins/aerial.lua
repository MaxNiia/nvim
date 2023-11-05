local attach = function(bufnr)
	local wk = require("which-key")
	wk.register({
		["[a"] = {
			"<cmd>AerialPrev<CR>",
			"Previous Aerial",
		},
		["]a"] = {
			"<cmd>AerialNext<CR>",
			"Next Aerial",
		},

		{
			["<leader>"] = {
				A = {
					name = "Aerial",
					k = {
						"<cmd>AerialPrev<CR>",
						"Previous Aerial",
					},
					j = {
						"<cmd>AerialNext<CR>",
						"Next Aerial",
					},
					t = {
						"<cmd>AerialToggle<CR>",
						"Toggle Aerial",
					},
				},
			},
		},
	}, {
		buffer = bufnr,
	})
	wk.register({}, {
		buffer = bufnr,
	})
end

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
			on_attach = attach,
			buftype_exclude = {
				"nofile",
				"terminal",
			},
			char = "▏",
			context_char = "▏",
			show_current_context = true,
			use_treesitter = true,
			filetype_exclude = require("utils.exclude_files"),
		},
	},
}
