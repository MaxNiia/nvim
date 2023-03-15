return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		dependencies = {
			"s1n7ax/nvim-window-picker",
			-- "miversen33/netman.nvim",
		},
		cmd = "Neotree",
		keys = {
			{
				"<leader>e",
				function()
					require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
				end,
				desc = "Explorer NeoTree (cwd)",
			},
			{ "<leader>E", "<leader>E", desc = "Explorer NeoTree", remap = true },
		},
		deactivate = function()
			vim.cmd([[Neotree close]])
		end,
		init = function()
			vim.g.neo_tree_remove_legacy_commands = 1
			if vim.fn.argc() == 1 then
				local stat = vim.loop.fs_stat(vim.fn.argv(0))
				if stat and stat.type == "directory" then
					require("neo-tree")
				end
			end
		end,
		opts = {

			source_selector = {
				winbar = true,
			},
			sources = {
				"filesystem",
				"buffers",
				"git_status",
				-- "netman.ui.neo-tree",
			},
			event_handlers = {
				{
					event = "neo_tree_buffer_enter",
					handler = function(
						_ --[[arg]]
					)
						vim.cmd([[
					  setlocal relativenumber
					]])
						vim.cmd([[
					  setlocal number
					]])
					end,
				},
			},
			filesystem = {
				bind_to_cwd = false,
				follow_current_file = true,
			},
			window = {
				mappings = {
					["<space>"] = "none",
					["S"] = "split_with_window_picker",
					["s"] = "vsplit_with_window_picker",
				},
			},
		},
		config = function(_, opts)
			require("neo-tree").setup(opts)
		end,
	},
}
