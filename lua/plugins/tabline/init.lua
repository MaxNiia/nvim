local utils = require("plugins.tabline.utils")

return {
	{
		"kdheepak/tabline.nvim",
		dependencies = {
			"nvim-lualine/lualine.nvim",
			"nvim-tree/nvim-web-devicons",
			"nvim-telescope/telescope.nvim",
		},
		event = "BufEnter",
		init = function()
			vim.cmd([[
				  set sessionoptions+=tabpages,globals " store tabpages and globals in session
				]])
		end,
		keys = {
			{
				"gb",
				"<cmd>TablineBufferNext<CR>",
				desc = "Next buffer",
			},
			{
				"gB",
				"<cmd>TablineBufferPrevious<CR>",
				desc = "Previous buffer",
			},
			{
				"<leader>Tr",
				utils.rename_tab,
				desc = "Rename tab",
			},
			{
				"<leader>Tt",
				"<cmd>TablineToggleShowAllBuffers<CR>",
				desc = "Toggle show buffers",
			},
			{
				"<leader>Tn",
				utils.new_tab,
				desc = "New tab",
			},
			{
				"<leader>Tb",
				utils.bind_buffers,
				desc = "Bind buffers",
			},
			{
				"<leader>Tc",
				"<cmd>TablineBuffersClearBind<CR>",
				desc = "Clear bind",
			},
		},
		opts = {
			enable = false,
			options = {
				modified_icon = " ",
				show_filename_only = true,
			},
		},
		config = function(_, opts)
			require("tabline").setup(opts)

			require("lualine").setup({
				tabline = {
					lualine_c = { require("tabline").tabline_buffers },
					lualine_x = { require("tabline").tabline_tabs },
				},
			})
		end,
	},
}
