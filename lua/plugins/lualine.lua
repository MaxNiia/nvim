return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"neovim/nvim-lspconfig",
			"nvim-neo-tree/neo-tree.nvim",
			"SmiteshP/nvim-navic",
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
					winbar = { "neo-tree", "dashboard", "lazy" },
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
				lualine_b = { "branch" },
				lualine_c = {
					{
						"diagnostics",
						symbols = {
							error = "",
							warn = "",
							info = "",
							hint = "",
						},
					},
					{
						"filetype",
						icon_only = true,
						separator = "",
						padding = { left = 1, right = 0 },
					},
					{ "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
					{
						function()
							return require("nvim-navic").get_location()
						end,
						cond = function()
							return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
						end,
					},
				},
				lualine_x = {
					{
						function()
							return require("noice").api.status.command.get()
						end,
						cond = function()
							return package.loaded["noice"] and require("noice").api.status.command.has()
						end,
					},
					{
						function()
							return require("noice").api.status.mode.get()
						end,
						cond = function()
							return package.loaded["noice"] and require("noice").api.status.mode.has()
						end,
					},
					{
						require("lazy.status").updates,
						cond = require("lazy.status").has_updates,
					},
					{
						"diff",
						symbols = {
							added = "",
							modified = "",
							removed = "",
						},
					},
				},
				lualine_y = {
					{ "progress", separator = " ", padding = { left = 1, right = 0 } },
					{ "location", padding = { left = 0, right = 1 } },
				},
				lualine_z = {
					function()
						return " " .. os.date("%R")
					end,
				},
			},
			extensions = {
				"aerial",
				"fzf",
				"neo-tree",
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
		},
		config = function(_, opts)
			require("lualine").setup(opts)
		end,
	},
}
