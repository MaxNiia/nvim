local utils = require("utils.telescope")

return {
	{
		"propet/colorscheme-persist.nvim",
		dependencies = {
			"catppuccin/nvim",
			"EdenEast/nightfox.nvim",
		},
		event = "VimEnter",
		keys = {
			{
				"<leader>fc",
				function()
					require("colorscheme-persist").picker()
				end,
				desc = "Colorscheme",
			},
		},
		opts = {
			-- In case there's no saved colorscheme yet
			fallback = "catppuccin-mocha", -- "catppuccin-mocha",
			-- List of ugly colorschemes to avoid in the selection window
			disable = {
				"darkblue",
				"default",
				"delek",
				"desert",
				"elflord",
				"evening",
				"industry",
				"koehler",
				"morning",
				"murphy",
				"pablo",
				"peachpuff",
				"ron",
				"shine",
				"slate",
				"torte",
				"zellner",
			},
			-- Options for the telescope picker
			picker_opts = {
				initial_mode = "insert",
				layout_strategy = "cursor",
				layout_config = utils.layouts.small_cursor,
				preview_cutoff = 0,
				enable_preview = true,
			},
		},
		config = function(_, opts)
			local persist_colorscheme = require("colorscheme-persist")

			-- Setup
			persist_colorscheme.setup(opts)

			-- Get stored colorscheme
			local colorscheme = persist_colorscheme.get_colorscheme()

			-- Set colorscheme
			vim.cmd.colorscheme(colorscheme)

			require("nightfox")
			require("catppuccin")
		end,
	},
}
