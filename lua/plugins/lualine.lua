return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"neovim/nvim-lspconfig",
		},
		lazy = true,
		opts = {
			options = {
				icons_enabled = true,
				theme = "auto",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = { "dashboard", "lazy" },
					winbar = { "NvimTree", "dashboard", "lazy" },
				},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = true,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = {
					{
						"filename",
						file_status = true,
						path = 1,
						shortng_target = 40,
						symbols = {
							modified = "", -- Text to show when the file is modified.
							readonly = "", -- Text to show when the file is non-modifiable or readonly.
							unnamed = "[No Name]", -- Text to show for unnamed buffers.
							newfile = "[New]", -- Text to show for newly created file before first write
						},
					},
					{
						"diagnostics",
						sources = {
							"nvim_diagnostic",
							"nvim_lsp",
						},
						sections = {
							"error",
							"warn",
							"info",
							"hint",
						},
						colored = true,
						always_visible = false,
						symbols = {
							error = "",
							warn = "",
							info = "",
							hint = "",
						},
					},
				},
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {},
			tabline = {},
			winbar = {
				lualine_a = {},
				lualine_b = {
					{
						"filetype",
						colored = true,
						icon_only = true,
						icon = { align = "right" },
					},
				},
				lualine_c = {
					{
						"filename",
						file_status = true,
						path = 1,
						shortng_target = 40,
						symbols = {
							modified = "", -- Text to show when the file is modified.
							readonly = "", -- Text to show when the file is non-modifiable or readonly.
							unnamed = "[No Name]", -- Text to show for unnamed buffers.
							newfile = "[New]", -- Text to show for newly created file before first write
						},
					},
				},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			inactive_winbar = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			extensions = {
				"aerial",
				"fzf",
				"nvim-tree",
			},
		},
		config = function(_, opts)
			require("lualine").setup(opts)
		end,
	},
}
