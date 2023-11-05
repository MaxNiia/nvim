return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"neovim/nvim-lspconfig",
			"nvim-neo-tree/neo-tree.nvim",
			"SmiteshP/nvim-navic",
			"AckslD/swenv.nvim",
		},
		lazy = true,
		opts = {
			options = {
				icons_enabled = true,
				theme = "auto",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {
						"dashboard",
						"lazy",
					},
					winbar = {
						"dapui_scopes",
						"dapui_breakpoints",
						"dapui_stacks",
						"dapui_console",
						"dapui_watches",
						"dapui_scopes",
						"dap-repl",
						"neo-tree",
						"dashboard",
						"lazy",
					},
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
						function()
							local venv = require("swenv.api").get_current_venv()
							if venv then
								return string.format("🐍 %s", venv.name)
							else
								return ""
							end
						end,
						seperator = " | ",
					},
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
						require("dap").status,
					},
				},
				lualine_y = {
					{
						"progress",
						separator = " ",
						padding = {
							left = 1,
							right = 0,
						},
					},
					{
						"location",
						padding = {
							left = 0,
							right = 1,
						},
					},
				},
				lualine_z = {
					{
						require("lazy.status").updates,
						cond = require("lazy.status").has_updates,
					},

					{
						function()
							return " " .. os.date("%R")
						end,
					},
				},
			},
			extensions = {
				"aerial",
				"fzf",
				"lazy",
				"neo-tree",
				"quickfix",
				"toggleterm",
				"trouble",
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
				lualine_x = {
					{
						"diagnostics",
						symbols = {
							error = "",
							warn = "",
							info = "",
							hint = "",
						},
					},
				},
				lualine_y = {
					{
						"diff",
						symbols = {
							added = "",
							modified = "",
							removed = "",
						},
					},
				},
				lualine_z = {},
			},
			inactive_winbar = {
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
		},
		config = function(_, opts)
			require("lualine").setup(opts)
		end,
	},
}
