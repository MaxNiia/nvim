return {
	{
		"tzachar/fuzzy.nvim",
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
		},
	},
	{
		"hrsh7th/cmp-buffer",
		dependencies = { "hrsh7th/nvim-cmp", "tzachar/fuzzy.nvim" },
	},
	{
		"windwp/nvim-autopairs",
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
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			{
				"L3MON4D3/LuaSnip",
				build = "make install_jsregexp",
			},
			"saadparwaiz1/cmp_luasnip",
		},
		opts = {
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			sources = {
				{ name = 'luasnip' }, },
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
