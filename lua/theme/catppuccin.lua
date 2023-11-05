vim.g.catppuccin_flavour = "mocha"

require("catppuccin").setup({
	flavour = "mocha",
	compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
	transparent_background = false,
	integrations = {
		aerial = true,
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
		mini = true,
		--neotree = true,
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
			-- Comment = { fg = c.rosewater }, For BQN.
			LineNr = { fg = c.rosewater},
		}
	end,
})

local colors = require("catppuccin.palettes").get_palette()
-- local latte = require("catppuccin.palettes").get_palette("latte")
-- local frappe = require("catppuccin.palettes").get_palette("frappe")
-- local macchiato = require("catppuccin.palettes").get_palette("macchiato")
local mocha = require("catppuccin.palettes").get_palette("mocha")
colors.none = "NONE"

vim.cmd("colorscheme catppuccin")

-- require("window-picker").setup({
-- 	-- the foreground (text) color of the picker
-- 	fg_color = mocha.pink,
-- 	-- if you have include_current_win == true, then current_win_hl_color will
-- 	-- be highlighted using this background color
-- 	current_win_hl_color = mocha.base,
-- 	-- all the windows except the current window will be highlighted using this
-- 	-- color
-- 	other_win_hl_color = mocha.crust,
-- })

require("lualine")
