require("nightfox").setup({
	options = {
		colorblind = {
			enable = true, -- Enable colorblind support
			simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
			severity = {
				protan = 1, -- Severity [0,1] for protan (red)
				deutan = 0.8, -- Severity [0,1] for deutan (green)
				tritan = 0, -- Severity [0,1] for tritan (blue)
			},
		},
	},
})

vim.cmd("colorscheme nordfox")

local palette = require("nightfox.palette").load("nordfox")

require("window-picker").setup({
	-- the foreground (text) color of the picker
	fg_color = palette.fg1,

	-- if you have include_current_win == true, then current_win_hl_color will
	-- be highlighted using this background color
	current_win_hl_color = palette.sel0,

	-- all the windows except the current window will be highlighted using this
	-- color
	other_win_hl_color = palette.sel0,
	autoselect_one = true,
})

require("lualine")
