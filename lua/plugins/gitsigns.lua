return {
	{
		"lewis6991/gitsigns.nvim",
		lazy = true,
		event = "BufEnter",
		opts = {
			signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
			numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
			linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
			word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
			current_line_blame = true,
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol",
				delay = 1000,
				ignore_whitespace = true,
			},
			current_line_blame_formatter = "<author>:<author_time:%Y:%m%d>-<summary>",
		},
		config = function(_, opts)
			require("gitsigns").setup(opts)
		end,
	},
}
