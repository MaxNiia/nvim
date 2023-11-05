return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		event = "BufEnter",
		opts = {
			compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
			transparent_background = false,
			integrations = {
				aerial = true,
				beacon = true,
				cmp = true,
				dashboard = true,
				gitsigns = true,
				fidget = true,
				harpoon = true,
				illuminate = true,
				indent_blankline = {
					enabled = true,
					colored_indent_levels = true,
				},
				leap = true,
				mason = true,
				markdown = true,
				mini = true,
				neotree = true,
				telescope = true,
				treesitter = true,
				treesitter_context = true,
				ts_rainbow2 = true,
				native_lsp = {
					enabled = true,
				},
				noice = true,
				notify = true,
				which_key = true,
			},
			custom_highlights = function(c)
				return {
					-- Comment = { fg = c.rosewater }, For BQN.
					-- LineNr = { fg = c.pink },
				}
			end,
		},
		config = function(_, opts)
			require("catppuccin").setup(opts)

			local colors = require("catppuccin.palettes").get_palette()
			colors.none = "NONE"

			require("lualine")
			require("lsp-inlayhints")
			require("telescope")
		end,
	},
}
