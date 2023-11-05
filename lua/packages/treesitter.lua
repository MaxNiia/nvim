require("nvim-treesitter").setup()

require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,

		-- Uses vim regex highlighting
		additional_vim_regex_highlighting = false,
	},
	rainbow = {
		enable = true,
		-- disable = { list of languages },
		extended_mode = true,
		max_file_lines = 10000
	},
})

require("treesitter-context").setup({
	enable = true,
	max_lines = 0,
	trim_scope = "outer",
})
