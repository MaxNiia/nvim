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
		aerial = {
			enabled = true,
		},
		beacon = {
			enabled = true,
		},
		bufferline = {
			enabled = true,
		},
		gitsigns = {
			enabled = true,
		},
		indent_blankline = {
			enabled = true,
			colored_indent_levels = true,
		},
		ts_rainbow = {
			enabled = true,
		},
		treesitter_context = {
			enabled = true,
		},
		nvimtree = {
			enabled = true,
		},
		telescope = {
			enabled = true,
		},
		treesitter = {
			enabled = true,
		},
		native_lsp = {
			enabled = true,
		},
		which_key = {
			enabled = true,
		},
	},
})

vim.api.nvim_command "colorscheme catppuccin"

