vim.g.catppuccin_flavour = "mocha"
local colors = require("catppuccin.palettes").get_palette()
-- local latte = require("catppuccin.palettes").get_palette "latte"
-- local frappe = require("catppuccin.palettes").get_palette "frappe"
-- local macchiato = require("catppuccin.palettes").get_palette "macchiato"
-- local mocha = require("catppuccin.palettes").get_palette "mocha"
colors.none = "NONE"

require("catppuccin").setup({
	flavour = "mocha",
	compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
	transparent_background = false,
	term_colors = true,
	dim_inactive = {
		enabled = true,
		percentage = 0.50,
	},
	styles = {
		comments = {},
		conditionals = {},
		loops = {},
		functions = {},
		keywords = {},
		strings = {},
		variables = {},
		numbers = {},
		booleans = {},
		properties = {},
		types = {},
		operators = {},
	},
	integrations = {
		aerial = true,
		beacon = true,
		cmp = true,
		dashboard = true,
		gitsigns = true,
		fidget = true,
		indent_blankline = {
			enabled = true,
			colored_indent_levels = true,
		},
		leap = true,
		mason = true,
		markdown = true,
		nvimtree = true,
		telescope = true,
		treesitter = true,
		treesitter_context = true,
		native_lsp = {
			enabled = true,
		},
		noice = true,
		notify = true,
		which_key = true,
	},
	custom_highlights = function(c)
		return {
			NoiceCursor = { fg = c.red },
			-- Comment = { fg = c.rosewater }, For BQN.
		}
	end,
})

vim.cmd("colorscheme catppuccin")

require("lualine")
