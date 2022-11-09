require("bufferline").setup({
	options = {
		mode = "buffers",
		indicator = {
			style = "underline",
		},

		diagnostics = "nvim_lsp",
		diagnostics_indicator = function(
			count, 
			level, 
			diagnostics_dict, 
			context
		)
			if context.buffer:current() then
				return ''
			end

			local s = " "
			for e, n in pairs(diagnostics_dict) do
				local sym = e == "error" and " " 
					or (e == "warning" and  " " or "")
				s = s .. n .. sym
			end
			return s
		end,
		offsets = {
			{
				filetype = "NvimTree",
				text = function()
					return vim.fn.getcwd()
				end,
				highlight = "Directory",
				text_align = "left",
			},
		},
		color_icons = true,
		separator_style = "slant",
		always_show_bufferline = true,
		hover = {
			{
				enabled = true,
				delay = 150,
				reveal = {"close"}
			},
		},
	},
	highlights = require("catppuccin.groups.integrations.bufferline").get(),
})

local wk = require("which-key")
wk.register({
	j = {
		"<cmd>BufferLinePick<CR>",
		"Open a buffer",
	},
	k = {
		"<cmd>BufferLinePickClose<CR>",
		"Close a buffer",
	},
}, {
	prefix = "<leader>"
})

