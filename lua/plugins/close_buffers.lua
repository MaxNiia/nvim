return {
	{
		"kazhala/close-buffers.nvim",
		dependencies = {
			"folke/which-key.nvim",
		},
		event = "VimEnter",
		opts = {
			filetype_ignore = {
				"neo-tree",
				"gitcommit",
				"qf",
				"trouble",
				"toggleterm",
			},
			preserve_window_layout = {
				"this",
				"nameless",
			},
		},
		config = function(_, opts)
			require("close_buffers").setup(opts)

			local wk = require("which-key")
			wk.register({
				q = {
					function()
						require("close_buffers").delete({ type = "this" })
					end,
					"Delete current buffer",
				},
				Q = {
					function()
						require("close_buffers").delete({ type = "other" })
					end,
					"Delete other buffers",
				},
			}, {
				prefix = "<leader>",
			})
		end,
	},
}
