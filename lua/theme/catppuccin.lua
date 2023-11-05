vim.g.catppuccin_flavour = "mocha"
local colors = require("catppuccin.palettes").get_palette()
local latte = require("catppuccin.palettes").get_palette("latte")
local frappe = require("catppuccin.palettes").get_palette("frappe")
local macchiato = require("catppuccin.palettes").get_palette("macchiato")
local mocha = require("catppuccin.palettes").get_palette("mocha")
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
		bufferline = true,
		beacon = true,
		cmp = true,
		dashboard = true,
		gitsigns = true,
		fidget = true,
		illuminate = true,
		indent_blankline = {
			enabled = true,
			colored_indent_levels = true,
		},
		leap = true,
		mason = true,
		markdown = true,
		neotree = true,
		telescope = true,
		treesitter = true,
		treesitter_context = true,
		ts_rainbow2 = true,
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

require("window-picker").setup({
	-- the foreground (text) color of the picker
	fg_color = mocha.text,

	-- if you have include_current_win == true, then current_win_hl_color will
	-- be highlighted using this background color
	current_win_hl_color = mocha.base,

	-- all the windows except the current window will be highlighted using this
	-- color
	other_win_hl_color = mocha.base,
	autoselect_one = true,
})

require("bufferline").setup({
	highlights = require("catppuccin.groups.integrations.bufferline").get(),
	options = {
		diagnostics = "nvim_lsp",
		always_show_bufferline = false,
		diagnostics_indicator = function(_, _, diag)
			local icons = { Error = " ", Warn = " ", Hint = " ", Info = " " }
			local ret = (diag.error and icons.Error .. diag.error .. " " or "")
				.. (diag.warning and icons.Warn .. diag.warning or "")
			return vim.trim(ret)
		end,
		offsets = {
			{
				filetype = "neo-tree",
				text = "Neo-tree",
				highlight = "Directory",
				text_align = "left",
			},
		},
	},
})

require("lualine")
