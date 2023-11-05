return {
	{
		"folke/trouble.nvim",
		event = "BufEnter",
		opts = {

			position = "bottom",
			icons = true,
			use_diagnostic_signs = true,
		},
		config = function(_, opts)
			require("trouble").setup(opts)
			local wk = require("which-key")
			wk.register({
				x = {
					name = "Trouble",
					x = {
						"<cmd>TroubleToggle<cr>",
						"Trouble",
					},
					w = {
						"<cmd>TroubleToggle workspace_diagnostics<cr>",
						"Workspace",
					},
					d = {
						"<cmd>TroubleToggle document_diagnostics<cr>",
						"Document",
					},
					q = {
						"<cmd>TroubleToggle quickfix<cr>",
						"Quickfix",
					},
					l = {
						"<cmd>TroubleToggle loclist<cr>",
						"Loc list",
					},
					r = {
						"<cmd>TroubleToggle lsp_references<cr>",
						"References",
					},
				},
			}, {
				prefix = "<leader>",
			})
		end,
	},
}
