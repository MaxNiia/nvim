vim.g.catppuccin_flavour = "macchiato"
local colors = require("catppuccin.palettes").get_palette()
colors.none = "NONE"
require("catppuccin").setup({
	transparent_background = false,
	term_colors = true,
	dim_inactive = {
		enabled = true,
		shade = "dark",
		percentage = 0.95,
	},
})
vim.api.nvim_command "colorscheme catppuccin"
