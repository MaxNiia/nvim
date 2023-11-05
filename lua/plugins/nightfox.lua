return {
	{
		"EdenEast/nightfox.nvim",
		dependencies = {
			"nvim-lualine/lualine.nvim",
		},
		name = "nightfox",
		opts = {
			options = {
				colorblind = {
					enable = true, -- Enable colorblind support
					simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
					severity = {
						protan = 1, -- Severity [0,1] for protan (red)
						deutan = 0.8, -- Severity [0,1] for deutan (green)
						tritan = 0, -- Severity [0,1] for tritan (blue)
					},
				},
			},
		},
		config = function(_, opts)
			require("nightfox").setup(opts)

			--require("lualine")

			-- setup must be called before loading
			-- vim.cmd.colorscheme("nightfox")
		end,
	},
}
