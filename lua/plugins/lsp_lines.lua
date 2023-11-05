return {
	{
		url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		keys = {
			{
				"<Leader>wT",
				require("lsp_lines").toggle,
				mode = "n",
				desc = "Toggle lsp_lines",
			},
		},
		init = function()
			vim.diagnostic.config({
				virtual_text = true,
				virtual_lines = { only_current_line = true },
			})
		end,
	},
}
