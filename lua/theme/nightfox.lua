require("nightfox").setup({
	options = {
		colorblind = {
			enable = false, -- Enable colorblind support
			simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
			severity = {
				protan = 0, -- Severity [0,1] for protan (red)
				deutan = 0, -- Severity [0,1] for deutan (green)
				tritan = 0, -- Severity [0,1] for tritan (blue)
			},
		},
	},
})

vim.cmd("colorscheme nightfox")

local palette = require("nightfox.palette").load("nightfox")

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

--[[
require("bufferline").setup({
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
]]
