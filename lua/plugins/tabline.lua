return {
	{
		"kdheepak/tabline.nvim",
		dependencies = { "nvim-lualine/lualine.nvim", "nvim-tree/nvim-web-devicons" },
		keys = {
			{
				"<tab>",
				"<cmd>TablineBufferNext<CR>",
				desc = "Next buffer",
			},
			{
				"<s-tab>",
				"<cmd>TablineBufferPrevious<CR>",
				desc = "Previous buffer",
			},
			-- {
			--     "<leader>Tr",
			--     function()
			--         return vim.ui.input({ prompt = "Enter tab name: " }, function(input)
			--             return "<cmd>TablineTabRename " .. tostring(input) .. " <CR>"
			--         end)
			--     end,
			--     desc = "Rename tab",
			-- },
			{
				"<leader>Tt",
				"<cmd>TablineToggleShowAllBuffers<CR>",
				desc = "Toggle all buffers",
			},
			-- {
			--     "<leader>Tn",
			--     function()
			--         return vim.ui.input({ prompt = "Enter files: " }, function(input)
			--             return "<cmd>TablineTabNew " .. tostring(input) .. " <CR>"
			--         end)
			--     end,
			--     desc = "New tab",
			-- },
			-- {
			--     "<leader>Tb",
			--     function()
			--         return vim.ui.input({ prompt = "Enter files: " }, function(input)
			--             return "<cmd>TablineBuffersBind " .. tostring(input) .. " <CR>"
			--         end)
			--     end,
			--     desc = "Bind buffers",
			-- },
			{
				"<leader>Tc",
				"<cmd>TablineClearBind<CR>",
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
