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
		main = "lsp_lines",
		config = function(_, opts)
			require("lsp_lines").setup(opts)
		end,
	},
}
