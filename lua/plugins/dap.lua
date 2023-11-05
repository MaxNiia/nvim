return {
	{
		"mfussenegger/nvim-dap",
		lazy = true,
		event = "BufEnter",
		dependencies = {
			"theHamsta/nvim-dap-virtual-text",
			dependencies = {
				"nvim-treesitter/nvim-treesitter"
			},
			opts = {
				enabled = true,
				enabled_commands = true,
				highlight_changed_variables = true,
				highlight_new_as_changed = true,
				all_references = false,
				show_stop_reason = true,
				commented = false,
				only_first_definition = true,
			},
			config = function(_, opts)
				require("nvim-dap-virtual-text").setup(opts)
			end,
		},
		config = true,
	},
}
