return {
	{
		"stevearc/oil.nvim",
		keys = {
			{ "g?", desc = "Show Help" },
			{ "<CR>", desc = "Select" },
			{ "<C-v>", desc = "Vertical split" },
			{ "<C-x>", desc = "Horizontal split" },
			{ "<C-t>", desc = "New tab" },
			{ "<C-p>", desc = "Preview" },
			{ "<C-c>", desc = "Close" },
			{ "<C-l>", desc = "Refresh" },
			{ "-", desc = "Parent" },
			{ "_", desc = "CWD" },
			{ "`", desc = "cd" },
			{ "~", desc = "tcd" },
			{ "g.", desc = "Toggle Hidden" },
			{ "<leader>e", "<cmd>Oil<cr>", desc = "Explorer" },
			{ "<leader>E", "<cmd>Oil --float<cr>", desc = "Explorer (float)" },
		},
		opts = {
			columns = {
				"icons",
			},
			buf_options = {
				buflisted = false,
				bufhidden = "hide",
			},
			win_options = {
				wrap = false,
				signcolumn = "no",
				cursorcolumn = "0",
				spell = false,
				list = false,
				conceallevel = 3,
				concealcursor = "n",
			},
			default_file_explorer = true,
			restore_win_options = true,
			skip_confirm_for_simple_edits = false,
			delete_to_trash = false,
			romt_save_on_select_new_entry = true,
			keymaps = {
				["g?"] = "actions.show_help",
				["<CR>"] = "actions.select",
				["<C-v>"] = "actions.select_vsplit",
				["<C-x>"] = "actions.select_split",
				["<C-t>"] = "actions.select_tab",
				["<C-p>"] = "actions.preview",
				["<C-c>"] = "actions.close",
				["<C-l>"] = "actions.refresh",
				["-"] = "actions.parent",
				["_"] = "actions.open_cwd",
				["`"] = "actions.cd",
				["~"] = "actions.tcd",
				["g."] = "actions.toggle_hidden",
			},
			view_options = {
				-- Show files and directories that start with "."
				show_hidden = false,
				-- This function defines what is considered a "hidden" file
				is_hidden_file = function(name, bufnr)
					return vim.startswith(name, ".")
				end,
				-- This function defines what will never be shown, even when `show_hidden` is set
				is_always_hidden = function(name, bufnr)
					return false
				end,
			},
			-- Configuration for the floating window in oil.open_float
			float = {
				-- Padding around the floating window
				padding = 2,
				max_width = 0,
				max_height = 0,
				border = "rounded",
				win_options = {
					winblend = 10,
				},
			},
			-- Configuration for the actions floating preview window
			preview = {
				-- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
				-- min_width and max_width can be a single value or a list of mixed integer/float types.
				-- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
				max_width = { 120, 0.9 },
				-- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
				min_width = { 80, 0.4 },
				-- optionally define an integer/float for the exact width of the preview window
				width = nil,
				-- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
				-- min_height and max_height can be a single value or a list of mixed integer/float types.
				-- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
				max_height = { 60, 0.9 },
				-- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
				min_height = { 12, 0.1 },
				-- optionally define an integer/float for the exact height of the preview window
				height = nil,
				border = "rounded",
				win_options = {
					winblend = 0,
				},
			},
			-- Configuration for the floating progress window
			progress = {
				max_width = 0.9,
				min_width = { 40, 0.4 },
				width = nil,
				max_height = { 10, 0.9 },
				min_height = { 5, 0.1 },
				height = nil,
				border = "rounded",
				minimized_border = "none",
				win_options = {
					winblend = 0,
				},
			},
		},
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
}
