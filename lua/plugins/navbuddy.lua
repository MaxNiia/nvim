return {
	{
		"MaxNiia/nvim-navbuddy",
		keys = {
			{ "<enter>", "<cmd>Navbuddy<cr>" },
		},
		dependencies = {
			"SmiteshP/nvim-navic",
			"MunifTanjim/nui.nvim",
			"nvim-telescope/telescope.nvim", -- Optional
		},
		opts = {
			lsp = { auto_attach = true },
		},
		config = function(_, opts)
			local actions = require("nvim-navbuddy.actions")
			opts["mappings"] = {
				["c"] = actions.mini_comment(),
			}

			require("nvim-navbuddy").setup(opts)
		end,
	},
}
