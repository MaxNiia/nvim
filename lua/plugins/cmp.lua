return {
	{
		"tzachar/fuzzy.nvim",
		lazy = true,
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
		},
	},
	{
		"hrsh7th/cmp-buffer",
		lazy = true,
		dependencies = { "hrsh7th/nvim-cmp", "tzachar/fuzzy.nvim" },
	},
	{
		"L3MON4D3/LuaSnip",
		lazy = true,
		build = "make install_jsregexp",
		opts = {
			history = true,
			region_check_events = "InsertEnter",
			delete_check_events = "TextChanged,InsertLeave",
		},
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		opts = {
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			matching = {
				disallow_fuzzy_matching = true,
				disallow_fullfuzzy_matching = true,
				disallow_partial_fuzzy_matching = true,
				disallow_partial_matching = true,
				disallow_prefix_unmatching = false,
			},
			experimental = {
				ghost_text = true,
			},
			sources = {
				{ name = "luasnip" },
			},
		},
	},
}
