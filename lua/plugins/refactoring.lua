return {
	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		lazy = true,
		event = "BufEnter",
		keys = {
			-- Remaps for the refactoring operations currently offered by the plugin
			{
				"<leader>rf",
				"<Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>",
				desc = "Extract function",
				mode = "v",
			},
			{
				"<leader>rF",
				"<Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>",
				desc = "Extract function to file",
				mode = "v",
			},
			{
				"<leader>re",
				"<Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>",
				desc = "Extract variable",
				mode = "v",
			},
			{
				"<leader>ri",
				"<Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>",
				desc = "Extract inline variable",
				mode = "v",
			},
			{
				"<leader>rb",
				"<Cmd>lua require('refactoring').refactor('Extract Block')<CR>",
				desc = "Extract Block",
			},
			{
				"<leader>rB",
				"<Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>",
				desc = "Extract block to file",
			},
			{
				"<leader>ri",
				"<Cmd>lua require('refactoring').refactor('Inline Variable')<CR>",
				desc = "Extract inline variable",
			},
			{
				"<leader>rp",
				":lua require('refactoring').debug.printf({below = false})<CR>",
				mode = "n",
				desc = "Print",
			},
			{
				"<leader>rP",
				":lua require('refactoring').debug.printf({below = true})<CR>",
				mode = "n",
				desc = "Print (below)",
			},
			{
				mode = "v",
				"<leader>rv",
				":lua require('refactoring').debug.print_var({})<CR>",
				desc = "Print var",
			},
			{
				mode = "n",
				"<leader>rv",
				":lua require('refactoring').debug.print_var({ normal = true })<CR>",
				desc = "Print var",
			},
			{
				mode = "n",
				"<leader>rc",
				":lua require('refactoring').debug.cleanup({})<CR>",
				desc = "Cleanup",
			},
		},
		opts = {
			prompt_func_return_type = {
				go = false,
				java = false,

				cpp = false,
				c = false,
				h = false,
				hpp = false,
				cxx = false,
			},
			prompt_func_param_type = {
				go = false,
				java = false,

				cpp = false,
				c = false,
				h = false,
				hpp = false,
				cxx = false,
			},
			printf_statements = {
				cpp = {
					'RFC_printf("%s")',
				},
				c = {
					'RFC_printf("%s")',
				},
			},
			print_var_statements = {
				cpp = {
					'RFC_printf("Path: %s -> %s")',
				},
				c = {
					'RFC_printf("Path: %s -> %s")',
				},
			},
		},
		config = function(_, opts)
			require("refactoring").setup(opts)
		end,
	},
}
