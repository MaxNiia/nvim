return {
	{
		"luukvbaal/statuscol.nvim",
		dependencies = {
			"mfussenegger/nvim-dap",
			"lewis6991/gitsigns.nvim",
		},
		lazy = true,
		event = "BufEnter",
		config = function()
			local builtin = require("statuscol.builtin")

			require("statuscol").setup({
				relculright = true,
				thousands = false,
				ft_ignore = {
					"neo-tree",
					"qf",
				},
				bt_ignore = {
					"terminal",
					"qf",
				},
				segments = {
					{
						text = {
							builtin.foldfunc,
							auto = true,
						},
						click = "v:lua.ScFa",
					},
					{
						sign = {
							name = {
								"Diagnostic",
							},
							maxwidth = 2,
							auto = true,
						},
						click = "v:lua.ScSa",
					},
					{
						text = {
							builtin.lnumfunc,
						},
						click = "v:lua.ScLa",
					},
					{
						sign = {
							name = {
								".*",
							},
							maxwidth = 1,
							colwidth = 1,
							auto = false,
						},
						click = "v:lua.ScSa",
					},
				},
				clickhandlers = {
					-- builtin click handlers
					Lnum = builtin.lnum_click,
					FoldClose = builtin.foldclose_click,
					FoldOpen = builtin.foldopen_click,
					FoldOther = builtin.foldother_click,
					DapBreakpointRejected = builtin.toggle_breakpoint,
					DapBreakpoint = builtin.toggle_breakpoint,
					DapBreakpointCondition = builtin.toggle_breakpoint,
					DiagnosticSignError = builtin.diagnostic_click,
					DiagnosticSignHint = builtin.diagnostic_click,
					DiagnosticSignInfo = builtin.diagnostic_click,
					DiagnosticSignWarn = builtin.diagnostic_click,
					GitSignsTopdelete = builtin.gitsigns_click,
					GitSignsUntracked = builtin.gitsigns_click,
					GitSignsAdd = builtin.gitsigns_click,
					GitSignsChange = builtin.gitsigns_click,
					GitSignsChangedelete = builtin.gitsigns_click,
					GitSignsDelete = builtin.gitsigns_click,
				},
			})
		end,
	},
}
