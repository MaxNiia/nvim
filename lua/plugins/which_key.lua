return {
	{
		"folke/which-key.nvim",
		lazy = true,
		config = function(_, _)
			local wk = require("which-key")
			wk.register({
				c = {
					"<cm:wqd>nohlsearch<CR>",
					"Clear highlight",
				},
				s = {
					"<cmd>wall<CR>",
					"Save all",
				},
			}, {
				prefix = "<leader>",
			})
		end,
	},
}
