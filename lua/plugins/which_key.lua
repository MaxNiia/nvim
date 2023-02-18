return {
	{
		"folke/which-key.nvim",
		lazy = true,
		config = function(_, _)
			local wk = require("which-key")
			wk.register({
				d = {
					function()
						vim.lsp.buf.format({
							async = true,
						})
					end,
					"Format",
				},
				a = {
					vim.lsp.buf.code_action,
					"Apply fix",
				},
				c = {
					"<cm:wqd>nohlsearch<CR>",
					"Clear highlight",
				},
				s = {
					"<cmd>wall<CR>",
					"Save all",
				},
				rn = {
					vim.lsp.buf.rename,
					"Rename",
				},
			}, {
				prefix = "<leader>",
			})
		end,
	},
}
