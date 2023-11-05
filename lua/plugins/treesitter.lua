return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-context",
				config = true,
			},
		},
		build = function()
			vim.cmd("TSUpdate")
		end,
		config = function()
			require("nvim-treesitter").setup()

			require("nvim-treesitter.configs").setup({
				highlight = {
					enable = true,
					use_languagetree = true,
					-- Uses vim regex highlighting
					additional_vim_regex_highlighting = false,
				},
				rainbow = {
					enable = true,
					-- disable = { list of languages },
					extended_mode = true,
					max_file_lines = 10000,
				},
				indent = {
					enable = true,
				},
				ensured_install = {
					"bash",
					"c",
					"cpp",
					"lua",
					"markdown",
					"markdown_inline",
					"python",
					"regex",
					"rust",
					"vim",
					"vimdoc",
				},
				auto_install = true,
			})

			require("treesitter-context").setup({
				enable = true,
				max_lines = 0,
				trim_scope = "outer",
			})
		end,
	},
}
