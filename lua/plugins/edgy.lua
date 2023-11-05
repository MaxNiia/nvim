return {
	{
		"folke/edgy.nvim",
		dependencies = {
			"echasnovski/mini.animate",
		},
		init = function()
			vim.opt.laststatus = 3
			vim.opt.splitkeep = "screen"
		end,
		event = "VeryLazy",
		keys = {
			{
				"<leader>ue",
				function()
					require("edgy").toggle()
				end,
				desc = "Edgy toggle Window",
			},
			{
				"<leader>uE",
				function()
					require("edgy").select()
				end,
				desc = "Edgy Select Window",
			},
		},
		opts = {
			wo = {
				winbar = true,
			},
			bottom = {
				"Trouble",
				{
					ft = "qf",
				},
				{
					ft = "help",
					-- only show help buffers
					filter = function(buf)
						return vim.bo[buf].buftype == "help"
					end,
				},
				{
					ft = "spectre_panel",
					open = function()
						require("spectre").open()
					end,
					size = { width = 40 },
				},
				"dapui_console",
				"dap-repl",
			},
			left = {
				{
					ft = "Outline",
					pinned = true,
					open = "SymbolsOutline",
				},
				"dapui_scopes",
				"dapui_breakpoints",
				"dapui_stacks",
				"dapui_watches",
				"dapui_scopes",
			},
			right = {
				{
					ft = "gitrebase",
					size = {
						width = 100,
					},
				},
				{
					ft = "gitcommit",
					size = {
						width = 72,
					},
				},
				-- PERF: Toggleterm performs terribly with edgy.
				-- {
				-- 	ft = "toggleterm",
				-- 	size = {
				-- 		width = function()
				-- 			return 100 -- math.min(vim.o.columns * 0.25, 100)
				-- 		end,
				-- 	},
				-- 	filter = function(_, win)
				-- 		return vim.api.nvim_win_get_config(win).relative == ""
				-- 	end,
				-- },
			},
		},
	},
}
