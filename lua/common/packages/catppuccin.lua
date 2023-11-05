vim.g.catppuccin_flavour = "macchiato"
local colors = require("catppuccin.palettes").get_palette()
colors.none = "NONE"
require("catppuccin").setup({
	transparent_background = false,
	term_colors = true,
	dim_inactive = {
		enabled = true,
		shade = "dark",
		percentage = 0.10,
	},
	integrations = {
		aerial = true,
		beacon = true,
		bufferline = true,
		gitsigns = true,
		indent_blankline = {
			enabled = true,
			colored_indent_levels = true,
		},
		ts_rainbow = true,
		treesitter_context = true,
		nvimtree = true,
		telescope = true,
		treesitter = true,
		native_lsp = {
			enabled = true,
		},
		which_key = true,
	},
})

vim.api.nvim_command "colorscheme catppuccin"

