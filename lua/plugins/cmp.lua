return {
	{
		"tzachar/fuzzy.nvim",
		lazy = true,
		dependencies = {
			{
				"MaxNiia/telescope-fzf-native.nvim",
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
		"windwp/nvim-autopairs",
		lazy = true,
		opts = {
			check_ts = true,
			ts_config = {},
		},
		config = function(_, opts)
			local npairs = require("nvim-autopairs")
			local Rule = require("nvim-autopairs.rule")

			npairs.setup(opts)

			local cond = require("nvim-autopairs.ts-conds")

			-- press % => %% only while inside a comment or string
			npairs.add_rules({
				Rule("%", "%")
					:with_pair(cond.is_ts_node({ "string", "comment" }))
					:with_pair(cond.is_not_ts_node({ "function" })),
			})
		end,
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
		config = function(_, opts)
			require("nvim-autopairs.completion.handlers")
			local cmp = require("cmp")
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			cmp.setup(opts)
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},
}
