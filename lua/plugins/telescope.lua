return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
			{
				"nvim-telescope/telescope-file-browser.nvim",
				dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
			},
			{
				"olimorris/persisted.nvim",
				opts = {
					use_git_branch = true,
					PersistedTelescopeLoadPre = function()
						vim.api.nvim_input("<ESC>:%bd<CR>")
					end,
					PersistedTelescopeLoadPost = function(session)
						print("Loaded session " .. session.name)
					end,
				},
				config = function(_, opts)
					require("persisted").setup(opts)
				end,
			},
			"nvim-telescope/telescope-dap.nvim",
			"mfussenegger/nvim-dap",
		},
		lazy = true,
		opts = {
			extensions = {
				file_browser = {
					hijack_netrw = true,
					display_stat = false,
				},
				aerial = {
					show_nesting = {
						["_"] = false,
					},
				},
				fzf = {
					fuzzy = true,
					override_gneric_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
			},
			defaults = {
				prompt_prefix = "   ",
				border = {},
				set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
				color_devicons = true,
				borderchars = {
					{ "─", "│", "─", "│", "┌", "┐", "┘", "└" },
					prompt = { "─", "│", " ", "│", "┌", "┬", "│", "│" },
					results = { "─", "│", "─", "│", "├", "┤", "┴", "└" },
					preview = { "─", "│", "─", " ", "─", "┐", "┘", "─" },
				},
				winblend = 0,
				wrap_results = false,
				path_display = { truncate = 20 },
				selection_caret = "  ",
				entry_prefix = "  ",
				initial_mode = "insert",
				selection_strategy = "reset",
				sorting_strategy = "ascending",
				prompt_title = "",
				results_title = "",
				preview_title = "",
				layout_stratergy = "horizontal",
				layout_config = {
					horizontal = {
						prompt_position = "top",
						height = 0.8,
						width = 0.9,
					},
					vertical = {
						mirror = false,
					},
				},
			},
		},
		config = function(_, opts)
			require("telescope").setup(opts)

			require("telescope.actions")
			require("trouble.providers.telescope")

			require("telescope").load_extension("aerial")
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("file_browser")
			require("telescope").load_extension("projects")
			require("telescope").load_extension("notify")
			require("telescope").load_extension("persisted")
			require("telescope").load_extension("noice")
			require("telescope").load_extension("dap")
		end,
	},
}
